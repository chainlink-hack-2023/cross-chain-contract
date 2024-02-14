// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract CreateOrderAtZkEVMScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0xf3A3a9e66a4765bCee90bC7DCb6b164a5e12b1B1;
        address GOERLI_USDC = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;
        address ZKEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        bytes memory _calldata = "0x";

        // Create order with maker token: 0.01 LINK and taker token: 0.00001 WETH
        // 

        console.log("Generate Order");
        LibOrder.Order memory order;
        order.makerToken = ZKEVM_LINK;
        order.makerAmount = 0.1 ether;
        order.takerToken = GOERLI_USDC;
        order.takerAmount = 1 * 1e6;
        order.maker = address(deployerAddress);
        order.expiry = uint64(1800537678);
        order.taker = address(0);
        order.salt = 2;
        order.targetChainId = 5;
        order.target = address(deployerAddress);
        order.permitSignature = _calldata;

        console.log("Create Order");
        HUBSource(_HUBSource).createOrder(order);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
