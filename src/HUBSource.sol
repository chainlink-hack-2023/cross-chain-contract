// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/HUBBase.sol";
import "src/libraries/SignatureVerification.sol";
import "src/interfaces/ISignatureTransfer.sol";
contract HUBSource is HUBBase {
    using SignatureVerification for bytes;
    /* ========== STATE VARIABLES ========== */
    address public HUBDestination;

    /* ========== ERROR  ========== */
    error SameSourceAndDestination();
    error IncorrectOrderStatus();
    error WrongTargetChainId();
    error AllowanceNotEnough();
    error AppoveFailed();
    error ExceedExpiry();

    /* ========== EVENTS ========== */
    event CreatedOrder(
        bytes32 OrderHash,
        LibOrder.Order order,
        LibOrder.OrderInfo orderInfo
    );
    event TargetMessageReceived(
        bytes32 MessageId,
        uint64 TargetChainSelector,
        address TargetHUBAddress,
        bytes32 OrderHash, 
        address TakerAddress, 
        uint128 TakerAmount, 
        address TakerAsset,
        uint128 errorCode
    );

    event TargetMessageSended(
        bytes32 MessageId,
        uint32 TargetChainId, 
        address Maker, 
        uint128 TakerAmount,
        address TakerAsset,
        uint128 ErrorCode
    );

    /* ========== CONSTANT ========== */
    bytes32 public constant _TOKEN_PERMISSIONS_TYPEHASH = keccak256("TokenPermissions(address token,uint256 amount)");
    bytes32 public constant _PERMIT_TRANSFER_FROM_TYPEHASH = keccak256(
        "PermitTransferFrom(TokenPermissions permitted,address spender,uint256 nonce,uint256 deadline)TokenPermissions(address token,uint256 amount)"
    );

    /* ========== CONSTRUCTOR  ========== */
    constructor() HUBBase() {}

    /* ========== ADMIN METHODS  ========== */
    function setHUBDestination(address _HUBDestination) onlyOwner external {
        HUBDestination = _HUBDestination;
    }

    /* ========== PUBLIC METHODS ========== */
    function createOrder(
        LibOrder.Order memory _order
    ) external payable nonReentrant whenNotPaused returns (bytes32) {
        return _createSaltedOrder(
            _order
        );
    }

    function executeMessageReceived(
        uint64 _targetChainSelector, 
        bytes32 _orderHash, 
        address _takerAddress, 
        uint128 _takerAmount, 
        address _takerAsset
    ) external payable nonReentrant whenNotPaused {
        _executeMessageReceived(_targetChainSelector, _orderHash, _takerAddress, _takerAmount, _takerAsset);
    }

    /* ========== INTERNAL ========== */
    function _createSaltedOrder(
        LibOrder.Order memory _order
    ) internal returns (bytes32) {
        _createdOrderValidation(_order);
        bytes32 _orderHash = LibOrder.getOrderStructHash(_order);

        LibOrder.OrderInfo storage _orderInfo = ordersInfo[_orderHash];
        if (_orderInfo.status != LibOrder.OrderStatus.INVALID) {
            revert IncorrectOrderStatus();
        }
        _orderInfo.status = LibOrder.OrderStatus.FILLABLE;
        _orderInfo.takerTokenFilledAmount = 0;

        LibOrder.Order storage order = orders[_orderHash];
        {
            order.makerToken = _order.makerToken;
            order.makerAmount = _order.makerAmount;
            order.takerToken = _order.takerToken;
            order.takerAmount = _order.takerAmount;
            order.maker = _order.maker;
            order.expiry = _order.expiry;
            order.taker = _order.taker;
            order.salt = _order.salt;
            order.targetChainId = _order.targetChainId;
            order.target = _order.target;
            order.permitSignature = _order.permitSignature;
        } 

        // transfer maker token into this
        IERC20(_order.makerToken).transferFrom(_order.maker, address(this), _order.makerAmount);

        emit CreatedOrder(
            _orderHash,
            _order,
            _orderInfo
        );

        return _orderHash;
    }

    // CCIP receive message callback
    function _ccipReceive(
        Client.Any2EVMMessage memory message
    ) internal override {
        bytes32 _messageId = message.messageId;
        uint64 _targetChainSelector = message.sourceChainSelector;
        address _targetHUBAddress = abi.decode(message.sender, (address));
        (bytes32 _orderHash, address _takerAddress, uint128 _takerAmount, address _takerAsset) = abi.decode(message.data, (bytes32, address, uint128, address));

        uint128 _errorCode = _executeMessageReceived(_targetChainSelector, _orderHash, _takerAddress, _takerAmount, _takerAsset);

        emit TargetMessageReceived(
            _messageId,
            _targetChainSelector,
            _targetHUBAddress,
            _orderHash, 
            _takerAddress,
            _takerAmount,
            _takerAsset,
            _errorCode
        );
    }

    // polygonZkEVMBridge receive message callback
    function onMessageReceived(
        address _targetHUBAddress,
        uint32 _targetChainSelector,
        bytes memory data
    ) external payable override {
        (bytes32 _orderHash, address _takerAddress, uint128 _takerAmount, address _takerAsset) = abi.decode(data, (bytes32, address, uint128, address));

        uint128 _errorCode = _executeMessageReceived(uint64(_targetChainSelector), _orderHash, _takerAddress, _takerAmount, _takerAsset);

        emit TargetMessageReceived(
            "",
            uint64(_targetChainSelector),
            _targetHUBAddress,
            _orderHash, 
            _takerAddress,
            _takerAmount,
            _takerAsset,
            _errorCode
        );
    }

    // receive message process
    function _executeMessageReceived(uint64 _targetChainSelector, bytes32 _orderHash, address _takerAddress, uint128 _takerAmount, address _takerAsset) internal returns (uint128 _errorCode) {
        LibOrder.Order storage _order = orders[_orderHash];
        _errorCode = _receivedOrderValidation(_order, _targetChainSelector, _takerAddress, _takerAsset);

        uint128 _filledAmount = 0;

        if (_errorCode == 0 ) {
            _filledAmount = _takerAmount * _order.makerAmount / _order.takerAmount;

            // update order status and filledAmount
            LibOrder.OrderInfo storage _orderInfo = ordersInfo[_orderHash];
            if (_orderInfo.status == LibOrder.OrderStatus.FILLED) {
                // Order filled
                _errorCode = 4;
            }

            uint128 notFilledAmount = _order.makerAmount - _orderInfo.takerTokenFilledAmount;
            if (_filledAmount > notFilledAmount) {
                _filledAmount = notFilledAmount;
            }
            
            _orderInfo.takerTokenFilledAmount += _filledAmount;

            if (_orderInfo.takerTokenFilledAmount >= _order.makerAmount) {
                _orderInfo.status = LibOrder.OrderStatus.FILLED;
            } else {
                _orderInfo.status = LibOrder.OrderStatus.FILLABLE;
            }
        }

        if (_errorCode == 0 ) {
            // transfer token
            IERC20(_order.makerToken).approve(address(this), type(uint).max);
            IERC20(_order.makerToken).transferFrom(address(this), _takerAddress, _filledAmount);
        }
        return _errorCode;

        // send message back to target chain
        // if (CCIPMessageType) {
        //     _ccipMessageSend(_order.targetChainId, _order.maker, _takerAmount, _order.takerToken, _errorCode);
        // } else {
        //     _zkBridgeMessageSend(_order.targetChainId, _order.maker, _takerAmount, _order.takerToken, _errorCode);
        // }
    }

    // // CCIP message send
    // function _ccipMessageSend(uint32 _targetChainId, address _maker, uint128 _takerAmount, address _takerAsset, uint128 _errorCode) internal {
    //     Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
    //         receiver: abi.encode(HUBDestination),
    //         data: abi.encode(_maker, _takerAmount, _takerAsset, _errorCode),
    //         tokenAmounts: new Client.EVMTokenAmount[](0),
    //         extraArgs: "",
    //         feeToken: LINK
    //     });

    //     uint64 targetCCIPChainSelector = chainSelectors[_targetChainId];
    //     bytes32 messageId = IRouterClient(i_router).ccipSend(
    //         targetCCIPChainSelector,
    //         message
    //     );

    //     emit TargetMessageSended(messageId, _targetChainId, _maker, _takerAmount, _takerAsset, _errorCode);

    // }

    // // Polygon zkBridge message send
    // function _zkBridgeMessageSend(
    //     uint32 _targetChainId,
    //     address _maker, 
    //     uint128 _takerAmount, 
    //     address _takerAsset, 
    //     uint128 _errorCode
    // ) internal {
    //     bytes memory _message = abi.encode(_maker, _takerAmount, _takerAsset, _errorCode);
    //     bool forceUpdateGlobalExitRoot = true;
    //     uint64 targetCCIPChainSelector = chainSelectors[_targetChainId];
    //     polygonZkEVMBridge.bridgeMessage(
    //         uint32(targetCCIPChainSelector),
    //         HUBDestination,
    //         forceUpdateGlobalExitRoot,
    //         _message
    //     );

    //     emit TargetMessageSended("", _targetChainId, _maker, _takerAmount, _takerAsset, _errorCode);
    // }

    function _createdOrderValidation(LibOrder.Order memory _order) internal view {
        // Check target chainId
        if (_order.targetChainId == uint32(block.chainid)) {
            revert SameSourceAndDestination();
        }

        // Check expiry
        if (_order.expiry < block.timestamp) {
            revert ExceedExpiry();
        }
    }

    function _receivedOrderValidation(
        LibOrder.Order storage _order, 
        uint64 _targetChainSelector,
        address _takerAddress, 
        address takerAsset
    ) internal view returns (uint128) {
        uint64 _orderTargetChainSelector = chainSelectors[_order.targetChainId];
        if (_orderTargetChainSelector != _targetChainSelector) {
            // Wrong target chain id or order not exist.
            return 1;
        }

        if (_order.taker != address(0)) {
            if (_order.taker != _takerAddress) {
                // Wrong taker address
                return 2;
            }
        }
        
        if (_order.takerToken != takerAsset) {
            // Wrong taker token
            return 3;
        }

        // Check expiry
        if (_order.expiry < block.timestamp) {
            return 5;
        }

        return 0;
    }  
}