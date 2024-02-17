// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract FulfilOrderAtSepoliaToBlastSepoliaScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBDestination = 0x7742b2C9cca5E9558e93474be5f825dF6707B5c2;
        address Sepolia_USDC = 0xbe72E441BF55620febc26715db68d3494213D8Cb;

        // Fulfill order 
        console.log("Generate Fulfill Order");
        bytes32 _orderHash = 0xbc1d8f1bcffff2eeb97e49e98049326495ab92626cff375da8e4d851cdb03689;
        uint128 takerAmount = 0.2 ether;
        address takerAsset = Sepolia_USDC;
        uint32 sourceChainId = 11155420;
        address maker = 0x3C53E585FDbDB1067B94985377582D7712dF4884;

        console.log("Fulfill Order");
        HUBDestination(_HUBDestination).fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId, maker);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
