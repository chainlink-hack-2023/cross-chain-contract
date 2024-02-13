// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "src/HUBSource.sol";
import "src/HUBDestination.sol";
import "src/libraries/LibOrder.sol";
import {ISignatureTransfer} from "src/interfaces/ISignatureTransfer.sol";

contract CreateOrderAtGoerliScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("Caller: ", deployerAddress);
        vm.startBroadcast(deployerPrivateKey);
        address _HUBSource = 0x2db63ba5F9101F5017a33922AE1c3C329e516625;
        address GOERLI_USDC = 0x07865c6E87B9F70255377e024ace6630C1Eaa37F;
        address ZKEVM_LINK = 0xa375fEfcA27a639361139718145dffc29A44cB6d;

        bytes memory _calldata = "0x";

        // Create order with maker token: 0.01 LINK and taker token: 0.00001 WETH
        // 

        console.log("Generate Order");
        LibOrder.Order memory order;
        order.makerToken = GOERLI_USDC;
        order.makerAmount = 1 * 1e6;
        order.takerToken = ZKEVM_LINK;
        order.takerAmount = 0.1 ether;
        order.maker = address(deployerAddress);
        order.expiry = uint64(1800537678);
        order.taker = address(0);
        order.salt = 2;
        order.targetChainId = 1442;
        order.target = address(deployerAddress);
        order.permitSignature = _calldata;

        console.log("Create Order");
        HUBSource(_HUBSource).createOrder(order);

        console.log("DONE!");
        vm.stopBroadcast();
    }
}
