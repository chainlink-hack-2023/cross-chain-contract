// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract FulfilOrderAtOPSepoliaScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBDestination = 0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E;
        address OPSepolia_WETH = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        // Fulfill order 
        console.log("Generate Fulfill Order");
        bytes32 _orderHash = 0x379384e888a48e745eb7c28aeaebd73b10f0eac1721a44dcdec069ae409fbee9;
        uint128 takerAmount = 0.00001 ether;
        address takerAsset = OPSepolia_WETH;
        uint32 sourceChainId = 11155111;
        address maker = 0x3C53E585FDbDB1067B94985377582D7712dF4884;

        console.log("Fulfill Order");
        HUBDestination(_HUBDestination).fillOrder(_orderHash, takerAmount, takerAsset, sourceChainId, maker);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
