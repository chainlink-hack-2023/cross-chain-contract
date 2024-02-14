// SPDX-License-Identifier: AGPL-3.0

pragma solidity ^0.8.0;

/**
 * @dev Define interface for PolygonZkEVM Bridge message receiver
 */
interface ICrossDomainReceiver {
    function onCrossMessageReceived(
        uint64 _targetChainSelector,
        bytes32 _orderHash, 
        address _takerAddress,
        uint128 _takerAmount, 
        address _takerAsset
    ) external payable;
}
