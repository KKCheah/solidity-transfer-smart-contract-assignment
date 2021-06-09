pragma solidity 0.7.5;

contract transferAssignment{
    mapping(address => uint)balance;
    
    address owner;
    
    event depositCompleted(uint amount, address indexed depositedTo);
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _; // run the function
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    function addBalance() public payable returns(uint){
        balance[msg.sender]+=msg.value;
        emit depositCompleted(msg.value, msg.sender);
        
    }
    
    function showBalance() public view returns (uint){
        return balance[msg.sender];
    }
    
    function tranfer(uint _toTransfer, address _addressToTransfer) public returns (uint){
        require(balance[msg.sender]>=_toTransfer);
        balance[msg.sender]-=_toTransfer;
        balance[_addressToTransfer]+=_toTransfer;
    }
    
    function withdraw(uint _toWithdraw)public payable returns(uint){
        require(balance[msg.sender]>=_toWithdraw);
        msg.sender.transfer(_toWithdraw);
        balance[msg.sender]-=_toWithdraw;
    }
}