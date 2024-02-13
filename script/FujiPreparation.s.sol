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
        address _HUBSource = 0x2db63ba5F9101F5017a33922AE1c3C329e516625;
        // address _HUBDestination = 0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E;
        address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;

        IERC20(FUJI_LINK).approve(_HUBSource, type(uint).max);
        uint256 amount = 0.2 ether;
        IERC20(FUJI_LINK).transfer(_HUBSource, amount);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
