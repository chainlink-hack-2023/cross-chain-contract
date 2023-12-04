// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract GoerliPreparationScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0xab2F8f89Dc933712ae5Eb6348Fc9F67c605cBD85;
        // address _HUBDestination = 0xd28daF64BF29C91380978132a5F3A94f6D58fd57;
        address GOERLI_USDC = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;

        IERC20(GOERLI_USDC).approve(_HUBSource, type(uint).max);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
