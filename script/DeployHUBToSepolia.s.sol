// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
contract HUBScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("deployer: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        // address CCIPROUTER = 0x70499c328e1E2a3c41108bd3730F6670a44595D1; // mumbai
        // address LINK = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
        address Messager = 0x58Cc85b8D04EA49cC6DBd3CbFFd00B4B8D6cb3ef; // Sepolia Messager


        bytes32 _salt = "HUB5";
        HUBSource _HUBSource = new HUBSource{salt: _salt}();
        HUBDestination _HUBDestination = new HUBDestination{salt: _salt}();

        console.log("HUBSource owner: ");
        console.log(_HUBSource.owner());
        console.log("deployed HUBSource Address:");
        console.logAddress(address(_HUBSource));
        console.log("deployed HUBDestination Address:");
        console.logAddress(address(_HUBDestination));

        console.log("Set HUBSource MessagerAndReceiver.");
        _HUBSource.setMessagerAndReceiver(Messager, address(_HUBDestination));
        console.log("Set HUBSource ChainSelectors.");
        _HUBSource.setChainSelectors(11155420, 0);
        console.log("Set HUBSource HUBDestination.");
        _HUBSource.setHUBDestination(address(_HUBDestination));
        console.log("Set HUBDestination MessagerAndReceiver.");
        _HUBDestination.setMessagerAndReceiver(Messager, address(_HUBSource));
        console.log("Set HUBDestination ChainSelectors.");
        _HUBDestination.setChainSelectors(11155420, 0);
        console.log("Set HUBDestination HUBSource.");
        _HUBDestination.setHUBSource(address(_HUBSource));

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
