// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract ExecuteMessageReceivedAtOPSepoliaScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1;
        // address _HUBDestination = 0xAC639a69B329A01E727188f8d90ECeA3f6189243;
        address Sepolia_USDC = 0xbe72E441BF55620febc26715db68d3494213D8Cb;

        uint64 _targetChainSelector = 0;
        bytes32 _orderHash = 0xca0916468514211907bb02458090e8a7913a54e587cc436a1a42e67926f3d3f5;
        address _takerAddress = 0x139fA1BB8Fd919F84b09A7740B772b143f33D87B;
        uint128 _takerAmount = 0.2 ether;
        address _takerAsset = Sepolia_USDC;
        
        HUBSource(_HUBSource).executeMessageReceived(_targetChainSelector, _orderHash, _takerAddress, _takerAmount, _takerAsset);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
