// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract FujiPreparationScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0x7D573068bA00964A7Cc7C9E36380E494d406F381;
        // address _HUBDestination = 0x0Cb9cf26d4Bc141a066A3AcDf3ff51Be6Fb7899F;
        address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;

        IERC20(FUJI_LINK).approve(_HUBSource, type(uint).max);
        uint256 amount = 0.2 ether;
        IERC20(FUJI_LINK).transfer(_HUBSource, amount);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
