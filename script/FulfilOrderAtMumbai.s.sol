// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract FulfilOrderAtMumbaiScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBDestination = 0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E;
        // address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        // address MUMBAI_WETH = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;
        address MUMBAI_USDC = 0x0FA8781a83E46826621b3BC094Ea2A0212e71B23;

        // Fulfill order 
        console.log("Generate Fulfill Order");
        bytes32 _orderHash = 0x1823d0acbc6c5aad24fc6655f5fd727437aaa9f42c7143ba1a7d1c9e174bcd4c;
        uint128 takerAmount = 100000;
        address takerAsset = MUMBAI_USDC;
        uint32 sourceChainId = 43113;
        address maker = 0x3C53E585FDbDB1067B94985377582D7712dF4884;

        console.log("Fulfill Order");
        HUBDestination(_HUBDestination).fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId, maker);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
