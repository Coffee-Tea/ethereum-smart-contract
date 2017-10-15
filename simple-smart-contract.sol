pragma solidity ^0.4.13;


contract Ownable {
    
    address owner;
    
    function Ownable() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function transferOwnership(address newOwner) onlyOwner public {
        owner = newOwner;
    }
    
}
 
contract BussinesCard is Ownable {
    
    mapping (string => string) data;

    function getData(string key) public constant returns (string) {
        return data[key];
    }
    
    function setData(string key, string value) onlyOwner public {
        data[key] = value;
    }
}