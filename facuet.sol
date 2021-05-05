pragma solidity ^0.5.1;

interface ERC20 {
    function name() external view returns (string memory);
    function symbol() external view  returns (string memory);
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address owner) external view returns (uint256 _balance);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract Faucet {
    uint256 constant public tokenAmount = 1000000000000000000;
    uint256 constant public waitTime = 30 minutes;

    ERC20 public tokenInstance;
    
    mapping(address => uint256) lastAccessTime;

    constructor(address _tokenInstance) public {
        require(_tokenInstance != address(0));
        tokenInstance = ERC20(_tokenInstance);
    }
    
    function getBalanceOfToken() public view returns (uint _balance) {
        return tokenInstance.balanceOf(address(this));
    }
    
    function requestTokens() external  {
        require(allowedToWithdraw(msg.sender) , "requester claimed within the past 30mins");
        tokenInstance.transfer(msg.sender, tokenAmount);
        lastAccessTime[msg.sender] = block.timestamp + waitTime;
    }
    

    function allowedToWithdraw(address _address) public view returns (bool) {
        return lastAccessTime[_address] == 0 && block.timestamp >= lastAccessTime[_address];
    }
}
