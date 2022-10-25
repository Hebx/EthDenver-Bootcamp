// SPDX-License-Identifier: None

pragma solidity 0.8.17;


contract BootcampContract {
	address public owner;
	address public deadAdress;
    uint256 number;

	constructor() {
		owner = msg.sender;
		deadAdress = 0x000000000000000000000000000000000000dEaD;
	}

	function getAccountAddress() external view returns (address) {
		if (msg.sender == owner) {
			return deadAdress;
		} else {
			return owner;
		}
	}
    function store(uint256 num) public {
        number = num;
    }


    function retrieve() public view returns (uint256){
        return number;
    }
}
