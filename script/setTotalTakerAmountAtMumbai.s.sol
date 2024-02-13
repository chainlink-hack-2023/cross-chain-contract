// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract setTotalTakerAmountAtMumbaiScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        // address _HUBSource = 0x2db63ba5F9101F5017a33922AE1c3C329e516625;
        address _HUBDestination = 0xb0E99cd4B72564Df11aDCcB3902E7C91a20A782E;
        // address MUMBAI_WETH = 0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa;
        // address MUMBAI_LINK = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        address MUMBAI_USDC = 0x0FA8781a83E46826621b3BC094Ea2A0212e71B23;

        HUBDestination(_HUBDestination).setTotalTakerAmount(MUMBAI_USDC, 0);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
