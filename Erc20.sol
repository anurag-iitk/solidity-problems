// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract ERC20Basic is IERC20 {

    string public constant name = "ERC20Token";
    string public constant symbol = "ERC";
    uint public constant decimals = 18;
    uint public constant _totalSupply = 1000;


    mapping( address => uint ) balances;
    mapping( address => mapping( address => uint )) allowed;
    
    
    constructor( ){
        balances[msg.sender] = _totalSupply;
    }
    
    function totalSupply() override public pure returns(uint){
        return _totalSupply;
    }
    
    function balanceOf(address tokenOwner) override public view returns(uint){
        return balances[tokenOwner];
    }
    
    function transfer(address receiver, uint _amount) override public returns(bool){
        require(_amount <= balances[msg.sender], 'please check the balance');
        balances[msg.sender] -= _amount;
        balances[receiver] += _amount;
        emit Transfer(msg.sender, receiver, _amount);
        return true;
    }
    
    function approve(address delegate, uint _amount) override public returns(bool){
        allowed[msg.sender][delegate] = _amount;
        emit Approval(msg.sender, delegate, _amount);
        return true;
    }
    
    function allowance(address owner, address delegate) override public view returns(uint){
        return allowed[owner][delegate];
    }
    
    function transferFrom(address owner, address delegate, uint _amount) override public returns(bool){
        require( _amount <= balances[owner], 'enough amount');
        require ( _amount <= allowed[owner][msg.sender], 'Not Send');
        balances[owner] -= _amount;
        allowed[owner][msg.sender] -= _amount;
        balances[delegate] += _amount;
        emit Transfer(owner, delegate, _amount);
        return true;
        
    }


}


