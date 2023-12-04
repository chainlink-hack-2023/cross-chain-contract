// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract ExecuteMessageReceivedAtZkEVMScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        // address _HUBSource = 0xab2F8f89Dc933712ae5Eb6348Fc9F67c605cBD85;
        address _HUBDestination = 0xd28daF64BF29C91380978132a5F3A94f6D58fd57;
        address ZKEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        address _maker = 0x3C53E585FDbDB1067B94985377582D7712dF4884;
        uint128 _releaseAmount = 0.1 ether;
        address _takerAsset = ZKEVM_LINK;
        uint128 _errorCode = 0;
        
        HUBDestination(_HUBDestination).executeMessageReceived(_maker, _releaseAmount, _takerAsset, _errorCode);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
