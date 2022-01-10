pragma solidity 0.6.0;

contract uservar{
    struct customer{
        address add;
        uint amt;
    }
    customer public customer1;
    
    function change()public{
        customer1.add = 0xD9AF114C7dD4bc0575EBb74bcF1d7609D5a82f28;
        customer1.amt = 25;
    }
}