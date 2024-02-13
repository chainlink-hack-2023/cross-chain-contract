// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract CreateOrderAtFujiScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0x2db63ba5F9101F5017a33922AE1c3C329e516625;
        address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        address MUMBAI_USDC = 0x0FA8781a83E46826621b3BC094Ea2A0212e71B23;

        bytes memory _calldata = "0x";

        // Create order with maker token: 0.01 LINK and taker token: 0.00001 WETH
        // 

        console.log("Generate Order");
        LibOrder.Order memory order;
        order.makerToken = FUJI_LINK;
        order.makerAmount = 0.001 ether;
        order.takerToken = MUMBAI_USDC;
        order.takerAmount = 0.1 * 1e6;
        order.maker = address(deployerAddress);
        order.expiry = uint64(1800537678);
        order.taker = address(0);
        order.salt = 3;
        order.targetChainId = 80001;
        order.target = address(deployerAddress);
        order.permitSignature = _calldata;

        console.log("Create Order");
        HUBSource(_HUBSource).createOrder(order);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
