pragma solidity ^0.5.13;

contract SendMoney{
    
    address owner;
    
    struct Payment{
        uint amount;
        uint timestamp;
        
    }
    
    struct balance {
        uint totbalance;
        uint numpay;
        mapping(uint => Payment) payments;
    }
    mapping(address => balance)public balanceRecord;

    constructor()public{
        owner = msg.sender;
    }
    function sendmoney()public payable{
       balanceRecord[msg.sender].totbalance += msg.value ;
       Payment memory payment = Payment(msg.value,now);
       balanceRecord[msg.sender].payments[balanceRecord[msg.sender].numpay] = payment;
       balanceRecord[msg.sender].numpay +=1;
    }
    function getBalance()public view returns(uint){
        return address(this).balance;        
    }    
    
    function withdrew (address payable to,uint amt)public {
        require(balanceRecord[msg.sender].totbalance >=amt,"low balance");
        balanceRecord[msg.sender].totbalance -= amt;
        to.transfer(amt);
    }
    
    function withdrawall(address payable _to)public {
        uint balsend = balanceRecord[msg.sender].totbalance;
         balanceRecord[msg.sender].totbalance -= balsend;
        _to.transfer(balsend);
         
    }
    
}