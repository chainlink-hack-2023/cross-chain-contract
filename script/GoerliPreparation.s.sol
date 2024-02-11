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
        // address _HUBSource = 0x7D573068bA00964A7Cc7C9E36380E494d406F381;
        address _HUBDestination = 0x0Cb9cf26d4Bc141a066A3AcDf3ff51Be6Fb7899F;
        address GOERLI_USDC = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;

        IERC20(GOERLI_USDC).approve(_HUBDestination, type(uint).max);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
