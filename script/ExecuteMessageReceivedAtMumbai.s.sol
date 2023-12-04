// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract ExecuteMessageReceivedAtMumbaiScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        // address _HUBSource = 0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12;
        address _HUBDestination = 0x414d60E05439816B6F04bB6D326403B4799013b0;

        address _maker = 0x3C53E585FDbDB1067B94985377582D7712dF4884;
        uint128 _releaseAmount = 10000000000000;
        address _takerAsset = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;
        uint128 _errorCode = 0;
        
        HUBDestination(_HUBDestination).executeMessageReceived(_maker, _releaseAmount, _takerAsset, _errorCode);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
