// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/// @dev A library for common order operations.
library LibOrder {

    enum OrderStatus {
        INVALID,
        FILLABLE,
        FILLED,
        CANCELLED,
        EXPIRED
    }

    /// @dev order.
    struct Order {
        address makerToken;
        address takerToken;
        uint128 makerAmount;
        uint128 takerAmount;
        address maker;
        address taker;
        uint64 expiry;
        uint256 salt;
        uint32 targetChainId;
        address target;
        bytes permitSignature;
    }

    /// @dev Info on a limit or order.
    struct OrderInfo {
        OrderStatus status;
        uint128 takerTokenFilledAmount;
    }

    // keccak256("Order(address makerToken,address takerToken,uint128 makerAmount,uint128 takerAmount,address maker,address taker,uint64 expiry,uint256 salt,uint32 targetChainId,address target,bytes signature")
    bytes32 private constant ORDER_TYPEHASH = 0xc19ea9cfdd7469daa475009541af81bcdae1f6a343c46828acb2a8485c860ef6;

    /// @dev Get the struct hash of a order.
    /// @param order The order.
    /// @return structHash The struct hash of the order.
    function getOrderStructHash(Order memory order) internal pure returns (bytes32 structHash) {
        return keccak256(abi.encode(ORDER_TYPEHASH, order));
    }
}
