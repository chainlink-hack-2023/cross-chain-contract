// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "src/HUBSource.sol";
import "src/libraries/LibOrder.sol";
import "./mock/TestERC20.sol";
import "src/interfaces/IERC1271.sol";
contract HUBSourceTest is Test {
    HUBSource internal _HUBSource;
    address LINK;
    uint256 msgSenderPrivateKey;
    address msgSender;

    address FUJI_LINK;
    address MUMBAI_WETH;

    event CreatedOrder(
        bytes32 OrderHash,
        LibOrder.Order order,
        LibOrder.OrderInfo orderInfo
    );

    function setUp() public {
        // address CCIPROUTER = 0x70499c328e1E2a3c41108bd3730F6670a44595D1; // mumbai
        LINK = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        // address polygonZkEVMBridge = 0xF6BEEeBB578e214CA9E23B0e9683454Ff88Ed2A7; // zkEVM
        // address _HUBDestinationAddress = address(0);
        FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        MUMBAI_WETH = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;

        TestERC20 _ERC20 = new TestERC20();
        bytes memory _ERC20Code = address(_ERC20).code;
        vm.etch(LINK, _ERC20Code);

        msgSenderPrivateKey = 0x12341234;
        msgSender = vm.addr(msgSenderPrivateKey);
        console.log("msgSender:");
        console.log(msgSender);

        vm.prank(msgSender, msgSender);
        _HUBSource = new HUBSource();
        vm.prank(msgSender, msgSender);
        // _HUBSource.setCCIPRoouterAndLink(CCIPROUTER, LINK);
        // _HUBSource.setPolygonZkEVMBridge(polygonZkEVMBridge);

        // _HUBSource.setHUBDestination(_HUBDestinationAddress);
    }

    function test_CreateOrder() public {
        bytes memory _calldata = "0x";

        console.log("Generate order");
        // console.log("Generate Order");
        LibOrder.Order memory order;
        order.makerToken = FUJI_LINK;
        order.makerAmount = 0.01 ether;
        order.takerToken = MUMBAI_WETH;
        order.takerAmount = 0.00001 ether;
        order.maker = address(this);
        order.expiry = uint64(1800537678);
        order.taker = address(0);
        order.salt = 5;
        order.targetChainId = 80001;
        order.target = address(this);
        order.permitSignature = _calldata;

        LibOrder.OrderInfo memory orderInfo;
        orderInfo.status = LibOrder.OrderStatus.FILLABLE;
        orderInfo.takerTokenFilledAmount = 0;

        bytes32 _orderId = LibOrder.getOrderStructHash(order);

        vm.expectEmit();
        emit CreatedOrder(_orderId, order, orderInfo);

        console.log("Create order");
        vm.prank(msgSender, msgSender);
        _HUBSource.createOrder(order);
        console.log("DONE");
    }

    function isValidSignature(bytes32, bytes memory) external pure returns (bytes4 magicValue) {
        // return IERC1271.isValidSignature.selector;
        return 0;
    }

}
