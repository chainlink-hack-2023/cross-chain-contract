// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract CreateOrderAtOPSepoliaScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1;
        address Sepolia_USDC = 0xbe72E441BF55620febc26715db68d3494213D8Cb;
        address OPSepolia_WETH = 0x74A4A85C611679B73F402B36c0F84A7D2CcdFDa3;

        bytes memory _calldata = "0x";

        // Create order with maker token: 0.01 LINK and taker token: 0.00001 WETH
        // 

        console.log("Generate Order");
        LibOrder.Order memory order;
        order.makerToken = OPSepolia_WETH;
        order.makerAmount = 0.00001 ether;
        order.takerToken = Sepolia_USDC;
        order.takerAmount = 0.2 ether;
        order.maker = address(deployerAddress);
        order.expiry = uint64(1800537678);
        order.taker = address(0);
        order.salt = 3;
        order.targetChainId = 11155111;
        order.target = address(deployerAddress);
        order.permitSignature = _calldata;

        console.log("Create Order");
        HUBSource(_HUBSource).createOrder(order);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
