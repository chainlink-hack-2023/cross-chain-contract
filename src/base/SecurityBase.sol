// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;


import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "lib/openzeppelin-contracts/contracts/security/Pausable.sol";
import "lib/openzeppelin-contracts/contracts/security/ReentrancyGuard.sol";

contract SecurityBase is Ownable, Pausable, ReentrancyGuard {

    constructor() Ownable() Pausable() ReentrancyGuard() {
        transferOwnership(tx.origin);
    }

}