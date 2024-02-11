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
        address CCIPROUTER = 0x554472a2720E5E7D5D3C817529aBA05EEd5F82D8; // fuji
        address LINK = 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846;
        // address polygonZkEVMBridge = 0xF6BEEeBB578e214CA9E23B0e9683454Ff88Ed2A7; // zkEVM

        bytes32 _salt = "HUB1";
        HUBSource _HUBSource = new HUBSource{salt: _salt}();
        HUBDestination _HUBDestination = new HUBDestination{salt: _salt}();

        console.log("HUBSource owner: ");
        console.log(_HUBSource.owner());
        console.log("deployed HUBSource Address:");
        console.logAddress(address(_HUBSource));
        console.log("deployed HUBDestination Address:");
        console.logAddress(address(_HUBDestination));

        console.log("Set HUBSource CCIPRoouterAndLink.");
        _HUBSource.setCCIPRoouterAndLink(CCIPROUTER, LINK);
        console.log("Set HUBSource CcipChainSelectors.");
        _HUBSource.setChainSelectors(80001, 12532609583862916517);
        console.log("Set HUBSource HUBDestination.");
        _HUBSource.setHUBDestination(address(_HUBDestination));
        console.log("Set HUBDestination CCIPRoouterAndLink.");
        _HUBDestination.setCCIPRoouterAndLink(CCIPROUTER, LINK);
        console.log("Set HUBDestination CcipChainSelectors.");
        _HUBDestination.setChainSelectors(80001, 12532609583862916517);
        console.log("Set HUBDestination HUBSource.");
        _HUBDestination.setHUBSource(address(_HUBSource));
        
        console.log("DONE!");
        vm.stopBroadcast();
    }
}
