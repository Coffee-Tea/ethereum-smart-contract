
pragma solidity ^0.4.13;


contract Ownable {
    
    address owner;
    
    function Ownable() internal {
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


contract CoffeeTeaCoin is Ownable {
    
    string public constant name = "Coffee Tea Coin";
    string public constant symbol = "CTC";
    uint32 public constant decimal = 18;
    
    uint public totalSupply = 0;
    
    mapping (address => uint) balances;
    
    mapping (address => mapping (address => uint)) allowed;
    
    function balance_of(address _owner) public constant returns (uint balance) {
        return balances[_owner];
    }
    
    function transfer(address _to, uint _value) public returns (bool success) {
        //  'balances[_to] + _value >= balances[_to]' is the check to avoid variable overflow
        if (balances[msg.sender] >= _value && balances[_to] + _value >= balances[_to]) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
        if (balances[_from] >= _value && 
            balances[_to] + _value >= balances[_to] 
            && allowance(_from, msg.sender) >= _value
            ) {
            allowed[_from][msg.sender] -= _value;
            balances[_from] -= _value;
            balances[_to] += _value;
            Transfer(_from, _to, _value);
            return true;
        }
        return false;
    }
    
    function approve(address _spender, uint _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) public constant returns (uint remaining) {
        return allowed[_owner][_spender];
    }

    function mint(address _to, uint _value) public {
      assert(totalSupply + _value >= totalSupply && balances[_to] + _value >= balances[_to]);
      balances[_to] += _value;
      totalSupply += _value;
    }
    
    event Transfer(address indexed _sender, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}