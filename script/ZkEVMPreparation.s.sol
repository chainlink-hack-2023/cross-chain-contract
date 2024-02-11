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
        address _HUBSource = 0x7D573068bA00964A7Cc7C9E36380E494d406F381;
        // address _HUBDestination = 0x0Cb9cf26d4Bc141a066A3AcDf3ff51Be6Fb7899F;
        address ZkEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        IERC20(ZkEVM_LINK).approve(_HUBSource, type(uint).max);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
