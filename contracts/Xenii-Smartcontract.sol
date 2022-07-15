// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Xenii {
    // Transfer GPX to Xenii smart contract
    address owner;
    IERC20 token;
    mapping(address => uint256) balances;

    constructor(address _addressToken) {
        owner = msg.sender;
        token = IERC20(_addressToken);
    }
    
    function depositGPX(uint256 _amount) public returns (bool) {
        balances[msg.sender] += _amount;
        token.transferFrom(msg.sender, address(this), _amount);
        return true;
    }

    function getSmartContractBalance() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function payTable(uint256 _amount) public returns (bool) {
        require(_amount <= balances[msg.sender], "Not enough GPX for transaction");
        balances[msg.sender] -= _amount;
        token.transferFrom(address(this), owner, _amount);
        return true;
    }

    function withdrawGPX(uint256 _amount) public returns (bool) {
        require(_amount < balances[msg.sender]);
        balances[msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);
        return true;
    }
}