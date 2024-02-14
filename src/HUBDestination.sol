// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/HUBBase.sol";
contract HUBDestination is HUBBase {
    /* ========== STATE VARIABLES ========== */
    mapping(address => uint256) public totalTakerAmount;
    address public HUBSource;
    
    /* ========== ERROR  ========== */
    error WrongTakerAmount();
    error WrongSourceChainId();
    error WrongTargetOrOrderNotExist();
    error WrongTaker();
    error WrongTakerAsset();
    error OrderFiled();

    /* ========== EVENTS ========== */
    event FilledOrder(
        bytes32 OrderHash,
        address TakerAddress,
        uint256 TakerAmount,
        address TakerAsset,
        uint32 SourceChainId,
        bytes32 MessageId
    );

    event SourceMessageReceived(
        bytes32 MessageId,
        uint64 SourceChainSelector,
        address SourceHUBAddress,
        address Taker, 
        uint128 TakerAmount, 
        address TakerAsset,
        uint128 ErrorCode
    );

    /* ========== CONSTRUCTOR  ========== */
    constructor() HUBBase() {
    }

    /* ========== ADMIN METHODS  ========== */
    function setHUBSource(address _HUBSource) onlyOwner external {
        HUBSource = _HUBSource;
    }

    /* ========== PUBLIC METHODS ========== */
    function fillOrder(
        bytes32 _orderHash,
        uint128 takerAmount,
        address takerAsset,
        uint32 sourceChainId,
        address maker
    ) external payable nonReentrant whenNotPaused {
        return _fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId, maker);
        
    }

    // function executeMessageReceived(
    //     address _maker, 
    //     uint128 _releaseAmount, 
    //     address _takerAsset, 
    //     uint128 _errorCode
    // ) external payable nonReentrant whenNotPaused { 
    //     _executeMessageReceived(_maker, _releaseAmount, _takerAsset, _errorCode);
    // }

    /* ========== ADMIN METHODS  ========== */
    function setTotalTakerAmount(address token, uint256 amount) external onlyOwner() {
        totalTakerAmount[token] = amount;
    }

    /* ========== INTERNAL ========== */

    function _fillOrder(
        bytes32 _orderHash,
        uint128 takerAmount,
        address takerAsset,
        uint32 sourceChainId,
        address maker
    ) internal {

        if (sourceChainId == uint32(block.chainid)) {
            revert WrongSourceChainId();
        }

        // transfer takerAsset into this contract
        IERC20(takerAsset).transferFrom(msg.sender, address(this), takerAmount);

        if (IERC20(takerAsset).balanceOf(address(this)) < (totalTakerAmount[takerAsset] + uint256(takerAmount))) {
            revert WrongTakerAmount();
        }
        totalTakerAmount[takerAsset] = IERC20(takerAsset).balanceOf(address(this));

        // mumbai 80001
        // fuji 43113
        if ((sourceChainId == 80001) || (sourceChainId == 43113)) {
            _ccipMessageSend(_orderHash, takerAmount, takerAsset, sourceChainId);
        } else if ((sourceChainId == 11155420) || (sourceChainId == 11155111)) {
            _OPMessageSend(_orderHash, takerAmount, takerAsset, sourceChainId);
        } else {
            _zkBridgeMessageSend(_orderHash, takerAmount, takerAsset, sourceChainId);
        }
        
        // release token to taker
        IERC20(takerAsset).transfer(maker, takerAmount);
        totalTakerAmount[takerAsset] -= uint256(takerAmount);
    }

    function _ccipMessageSend(bytes32 _orderHash, uint128 _takerAmount, address _takerAsset, uint32 sourceChainId) internal {
        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
            receiver: abi.encode(HUBSource),
            data: abi.encode(_orderHash, msg.sender, _takerAmount, _takerAsset),
            tokenAmounts: new Client.EVMTokenAmount[](0),
            extraArgs: "",
            feeToken: LINK
        });

        uint64 sourceCCIPChainSelector = chainSelectors[sourceChainId];
        bytes32 messageId = IRouterClient(i_router).ccipSend(
            sourceCCIPChainSelector,
            message
        );
        
        emit FilledOrder(_orderHash, msg.sender, _takerAmount, _takerAsset, sourceChainId, messageId);
    }

    // Polygon zkBridge message send
    function _zkBridgeMessageSend(
        bytes32 _orderHash, 
        uint128 _takerAmount, 
        address _takerAsset, 
        uint32 _sourceChainId
    ) internal {
        bytes memory _message = abi.encode(_orderHash, msg.sender, _takerAmount, _takerAsset);
        bool forceUpdateGlobalExitRoot = true;
        uint64 sourceCCIPChainSelector = chainSelectors[_sourceChainId];
        polygonZkEVMBridge.bridgeMessage(
            uint32(sourceCCIPChainSelector),
            HUBSource,
            forceUpdateGlobalExitRoot,
            _message
        );

        emit FilledOrder(_orderHash, msg.sender, _takerAmount, _takerAsset, _sourceChainId, "");
    }

    function _OPMessageSend(
        bytes32 _orderHash, 
        uint128 _takerAmount, 
        address _takerAsset,
        uint32 _sourceChainId
    ) internal {
        uint64 sourceCCIPChainSelector = chainSelectors[_sourceChainId];

        MESSENGER.sendMessage(
            RECEIVER,
            abi.encodeCall(
                this.onCrossMessageReceived,
                (
                    sourceCCIPChainSelector,
                    _orderHash, 
                    msg.sender, 
                    _takerAmount, 
                    _takerAsset
                )
            ),
            1000000
        );

        emit FilledOrder(_orderHash, msg.sender, _takerAmount, _takerAsset, _sourceChainId, "");
    }

    // // CCIP receive message callback
    function _ccipReceive(Client.Any2EVMMessage memory message) internal override {
        return;
    }

    function onMessageReceived(
        address originAddress,
        uint32 originNetwork,
        bytes memory data
    ) external payable {
        return;
    }

    function onCrossMessageReceived(
        uint64 _targetChainSelector,
        bytes32 _orderHash, 
        address _takerAddress,
        uint128 _takerAmount, 
        address _takerAsset
    ) external payable {
        return;
    }
}