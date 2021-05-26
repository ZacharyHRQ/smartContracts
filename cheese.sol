// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

/** 
 * @title CheeseTouch
 * @dev Implements the game of CheeseTouch
 */

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0-beta.0/contracts/token/ERC721/ERC721Full.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0-beta.0/contracts/drafts/Counters.sol";

contract CheeseTouch is ERC721Full {
    struct Touch{
        address player;
        uint time;
    }
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    mapping(uint => Touch) public touches; 

    constructor() ERC721Full("CheeseTouch", "CHT") public {
    }
    
    function createTouch(address player) public returns (uint256) {
        uint256 newItemId = _tokenIds.current();
        require(touches[newItemId].time == now+ 1 days );
        _tokenIds.increment();
        newItemId = _tokenIds.current();
        _mint(player, newItemId);
        touches[newItemId] = Touch(player,now); 

        return newItemId;
    }
    
    function passTouch(address player) public returns (address){ 
        uint256 newItemId = _tokenIds.current();
        require(msg.sender == touches[newItemId].player);
        touches[newItemId].player = player;
        return player;
    }
    
    function getTouched() public view returns (address){ 
        uint256 newItemId = _tokenIds.current();
        require(touches[newItemId].time == now+ 1 days, "No tokens are live now");
        return touches[newItemId].player;
    }
    
    
}
