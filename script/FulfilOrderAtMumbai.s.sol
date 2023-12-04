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
        address _HUBDestination = 0x414d60E05439816B6F04bB6D326403B4799013b0;
        // address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        // address MUMBAI_WETH = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;
        address MUMBAI_USDC = 0x0FA8781a83E46826621b3BC094Ea2A0212e71B23;

        // Fulfill order 
        console.log("Generate Fulfill Order");
        bytes32 _orderHash = 0x5cb724e0924cc270b4754ef75c38f708959d2b00ad98de25aaad4e2c948f9bc3;
        uint128 takerAmount = 100000;
        address takerAsset = MUMBAI_USDC;
        uint32 sourceChainId = 43113;

        console.log("Fulfill Order");
        HUBDestination(_HUBDestination).fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
