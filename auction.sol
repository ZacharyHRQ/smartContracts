//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Auction {
    string public name = "Attention Auction";
    address public owner;

    struct display {
        uint256 price;
        string url;
        string name;
        address contributor;
    }

    display public currentDisplay;

    constructor() {
        owner = msg.sender;
    }

    function newDisplay(
        uint256 _price,
        string memory _url,
        string memory _name
    ) public payable {
        require(currentDisplay.price < _price);
        currentDisplay.price = _price;
        currentDisplay.url = _url;
        currentDisplay.name = _name;
    }

    function getDisplay()
        public
        view
        returns (
            uint256 _price,
            string memory _url,
            string memory _name
        )
    {
        return (currentDisplay.price, currentDisplay.url, currentDisplay.name);
    }

    function withdraw() public {
        address payable _owner = payable(owner);
        _owner.transfer(address(this).balance);
    }
}
