// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract TokenTransferScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0xF9C32eb91aFa23A2fA4656A3a30611EEd3155F12;
        address _HUBDestination = 0x414d60E05439816B6F04bB6D326403B4799013b0;
        address FUJI_LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        address MUMBAI_LINK = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;

        uint256 amount = 0.2 ether;
        IERC20(FUJI_LINK).transfer(_HUBDestination, amount);
        IERC20(MUMBAI_LINK).transfer(_HUBSource, amount);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
