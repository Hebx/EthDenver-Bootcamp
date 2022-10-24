// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

// error NeedsOwner();
error TransferFailed();
error NotAllowed();

contract VolcanoCoin is Ownable {
    uint256 private totalSupply = 10000;
    address private owner;
    mapping(address => uint256) private balances;
    mapping(address => Payment[]) private transfers;

    event Mint(uint256 newTotalSupply);
    event Transfer(uint256 amount, address indexed recipient);

    struct Payment {
        uint256 amount;
        address recipient;
    }

    // modifier onlyOwner() {
    //     if (msg.sender != owner) {
    //         revert NeedsOwner();
    //     }
    //     _;
    // }

    constructor() {
        owner = msg.sender;
        balances[msg.sender] = totalSupply;
    }

    function mint() public onlyOwner {
        totalSupply += 1000;
        balances[owner] += 1000;
        emit Mint(totalSupply);
    }

    function getAccountBalance(address _account) public view returns (uint256){
        if (msg.sender != _account) revert NotAllowed();
        return balances[_account];
    }

    function getAccountTransfers(address _account) public view returns (Payment[] memory){
        if (msg.sender != _account) revert NotAllowed();
        return transfers[_account];
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function transfer(uint256 _amount, address _recipient) public {
        if (_amount > balances[msg.sender]) {
            revert TransferFailed();
        }
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        transfers[msg.sender].push(Payment(_amount, _recipient));
        emit Transfer(_amount, _recipient);
    }
}
