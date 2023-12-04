// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract FulfilOrderAtZkEVMScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBDestination = 0xd28daF64BF29C91380978132a5F3A94f6D58fd57;
        // address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        // address MUMBAI_WETH = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;
        address ZKEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        // Fulfill order 
        console.log("Generate Fulfill Order");
        bytes32 _orderHash = 0x379384e888a48e745eb7c28aeaebd73b10f0eac1721a44dcdec069ae409fbee9;
        uint128 takerAmount = 0.1 ether;
        address takerAsset = ZKEVM_LINK;
        uint32 sourceChainId = 5;

        console.log("Fulfill Order");
        HUBDestination(_HUBDestination).fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
