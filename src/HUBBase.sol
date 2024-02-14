// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "src/base/SecurityBase.sol";
import "./libraries/LibOrder.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import "./interfaces/IPolygonZkEVMBridge.sol";
import "./interfaces/IBridgeMessageReceiver.sol";
import {CCIPReceiver} from "src/base/CCIPReceiver.sol";

import "./interfaces/ICrossDomainMessenger.sol";
import "./interfaces/ICrossDomainReceiver.sol";

abstract contract HUBBase is SecurityBase, CCIPReceiver, IBridgeMessageReceiver {
    /* ========== STATE VARIABLES ========== */
    // orderHash => LibOrder.OrderInfo
    mapping(bytes32 => LibOrder.OrderInfo) public ordersInfo;

    // orderHash => LibOrder.Order
    mapping(bytes32 => LibOrder.Order) public orders;

    // chainId => ccipChainSelector
    mapping(uint32 => uint64) public chainSelectors;

    address internal LINK;

    // Global Exit Root address
    IPolygonZkEVMBridge public polygonZkEVMBridge;

    // OP MESSAGER and RECEIVER
    ICrossDomainMessenger public  MESSENGER;
    address public RECEIVER;

    /* ========== CONSTRUCTOR  ========== */

    constructor() SecurityBase() CCIPReceiver(address(0)) {}

    /* ========== ADMIN METHODS  ========== */
    function setCCIPRoouterAndLink(address _CCIProuter, address _link) onlyOwner external {
        i_router = _CCIProuter;
        LINK = _link;
        IERC20(LINK).approve(i_router, type(uint256).max);
    }

    function setPolygonZkEVMBridge(address _polygonZkEVMBridge) onlyOwner external {
        polygonZkEVMBridge = IPolygonZkEVMBridge(_polygonZkEVMBridge);
    }

    function setChainSelectors(uint32 _chianId, uint64 _chainSelectors) onlyOwner external {
        chainSelectors[_chianId] = _chainSelectors;
    }

    function setMessagerAndReceiver(address _messenger, address _receiver) onlyOwner() external {
        MESSENGER = ICrossDomainMessenger(_messenger);
        RECEIVER = _receiver;
    }

    /* ========== INTERNAL ========== */
    
}