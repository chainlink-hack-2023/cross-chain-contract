// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract OPSepoliaPreparationScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1;
        // address _HUBDestination = 0xAC639a69B329A01E727188f8d90ECeA3f6189243;
        address OPSepolia_WETH = 0x74A4A85C611679B73F402B36c0F84A7D2CcdFDa3;

        IERC20(OPSepolia_WETH).approve(_HUBSource, type(uint).max);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
