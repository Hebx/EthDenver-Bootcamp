// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VolcanoCoin {
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

    modifier onlyOwner() {
		require(msg.sender == owner, "Not Owner");
		_;
    }
    constructor() {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    function mint() public onlyOwner {
        totalSupply += 1000;
        balances[owner] += 1000;
        emit Mint(totalSupply);
    }

    function getAccountBalance(address _account) public view returns (uint256){
        require(msg.sender == _account, "Not Allowed");
        return balances[_account];
    }

    function getAccountTransfers(address _account) public view returns (Payment[] memory){
        require(msg.sender == _account, "Not Allowed");
        return transfers[_account];
    }

    function getTotalSupply() public view returns (uint256) {
        return totalSupply;
    }

    function transfer(uint256 _amount, address _recipient) public {
        require(_amount <= balances[msg.sender], "Not Enough");
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
        transfers[msg.sender].push(Payment(_amount, _recipient));
        emit Transfer(_amount, _recipient);
    }
}
