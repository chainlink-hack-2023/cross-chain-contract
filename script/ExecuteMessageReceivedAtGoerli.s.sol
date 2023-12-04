// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract ExecuteMessageReceivedAtGoerliScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0xab2F8f89Dc933712ae5Eb6348Fc9F67c605cBD85;
        // address _HUBDestination = 0xd28daF64BF29C91380978132a5F3A94f6D58fd57;
        address ZKEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        uint64 _targetChainSelector = 1;
        bytes32 _orderHash = 0x20f5dece0ab76468b694ad207b2a24f68de1699661c7041cbf0a1bc556f03299;
        address _takerAddress = 0x3C53E585FDbDB1067B94985377582D7712dF4884;
        uint128 _takerAmount = 100000000000000000;
        address _takerAsset = ZKEVM_LINK;
        bool CCIPMessageType = false;
        
        HUBSource(_HUBSource).executeMessageReceived(_targetChainSelector, _orderHash, _takerAddress, _takerAmount, _takerAsset, CCIPMessageType);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
