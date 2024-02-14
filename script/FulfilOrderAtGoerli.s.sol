// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract FulfilOrderAtGoerliScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBDestination = 0xAC639a69B329A01E727188f8d90ECeA3f6189243;
        // address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        // address MUMBAI_WETH = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;
        // address ZKEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;
        address GOERLI_USDC = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;

        // Fulfill order 
        console.log("Generate Fulfill Order");
        bytes32 _orderHash = 0xfa3a167d5342df0c8de7e3dc13be74f2f06abccfa6ecb3c062362825b8585e6a;
        uint128 takerAmount = 1 * 1e6;
        address takerAsset = GOERLI_USDC;
        uint32 sourceChainId = 1442;
        address maker = 0x3C53E585FDbDB1067B94985377582D7712dF4884;

        console.log("Fulfill Order");
        HUBDestination(_HUBDestination).fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId, maker);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
