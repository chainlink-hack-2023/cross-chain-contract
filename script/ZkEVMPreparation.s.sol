// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract ZkEVMPreparationScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        // address _HUBSource = 0xf57c41302BbD709F1E3eAa154E7Cc4C361671f7e;
        address _HUBDestination = 0xE1029eba9600E093f0A83601882d47a8Ecf5af03;
        address ZkEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        IERC20(ZkEVM_LINK).approve(_HUBDestination, type(uint).max);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
