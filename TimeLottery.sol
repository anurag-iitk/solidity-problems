// SPDX-License-Identifier: GPL-3.0

// create by: Anurag  Link:- https://dapp-world.com/user/anurag-saini-503i4

pragma solidity >=0.4.5 <0.9.0;

contract Lottery {
 
 struct lotteryInfo {
     uint start_time;
     uint ending_time;
     uint total_price;
     address payable[] participants;
     uint price;
 }
 
  lotteryInfo oneDay;
  lotteryInfo oneWeek;
  lotteryInfo oneMonth;
 
 address owner;
 
 constructor(){
    owner = msg.sender;    
 }
 
 modifier onlyOwner {
     require ( owner == msg.sender );
     _;
 }
 
 function setTime_oneDay(uint _ending_time) onlyOwner public {
     oneDay.start_time = block.timestamp;  // start with our current price.
     oneDay.ending_time = block.timestamp + _ending_time; // ending time must be in second.
 }
 
  function setTime_oneWeek(uint _ending_time) onlyOwner public {
     oneWeek.start_time = block.timestamp;  // start with our current price.
     oneWeek.ending_time = block.timestamp + _ending_time; // ending time must be in second.
 }
 
  function setTime_oneMonth(uint _ending_time) onlyOwner public {
     oneMonth.start_time = block.timestamp;  // start with our current price.
     oneMonth.ending_time = block.timestamp + _ending_time; // ending time must be in second.
 }
 
 function setPrice_oneDay(uint _price) onlyOwner public {
     oneDay.price = _price;  // minimum price for participating.
 } 
 
  function setPrice_oneWeek(uint _price) onlyOwner public {
     oneWeek.price = _price;  // minimum price for participating.
 } 
 
  function setPrice_oneMonth(uint _price) onlyOwner public {
     oneMonth.price = _price;  // minimum price for participating.
 } 
 
 function getParticipated_oneDay() public payable returns(bool){
     require ( msg.sender != owner, "Owner not send");
     require ( oneDay.start_time < block.timestamp, "Not started yet");
     require ( block.timestamp < oneDay.ending_time, "Pass out deadline");
     require ( msg.value == oneDay.price, "Invalid price");
     oneDay.participants.push(payable(msg.sender)); // push new participants in array.
     oneDay.total_price += msg.value;  // send this participant price add in our total price.
     return true;
 }
 
  function getParticipated_oneWeek() public payable returns(bool){
     require ( msg.sender != owner, "Owner not send");
     require ( oneWeek.start_time < block.timestamp, "Not started yet");
     require ( block.timestamp < oneWeek.ending_time, "Pass out deadline");
     require ( msg.value == oneWeek.price, "Invalid price");
     oneWeek.participants.push(payable(msg.sender)); // push new participants in array.
     oneWeek.total_price += msg.value;  // send this participant price add in our total price.
     return true;
 }
 
  function getParticipated_oneMonth() public payable returns(bool){
     require ( msg.sender != owner, "Owner not send");
     require ( oneMonth.start_time < block.timestamp, "Not started yet");
     require ( block.timestamp < oneMonth.ending_time, "Pass out deadline");
     require ( msg.value == oneMonth.price, "Invalid price");
     oneMonth.participants.push(payable(msg.sender)); // push new participants in array.
     oneMonth.total_price += msg.value;  // send this participant price add in our total price.
     return true;
 }
 
 function getRandom() onlyOwner public view returns(uint){
     return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender)));   // generate hashinh for random number.
 }
 
  function getWinner_oneDay() onlyOwner public payable returns(address){
     require ( oneDay.ending_time > block.timestamp, "currently not opening lottery" );  
     uint index = getRandom() % oneDay.participants.length;    // To find the index value. Ex: 123 % 5 answer will be smaller than 5.
     address payable winner = oneDay.participants[index];    // declare the winner.
     uint prize = oneDay.total_price;   
     winner.transfer(prize);      // transfer total price to winner.
     delete oneDay.participants;  // delete this dynamic array
     oneDay.total_price = 0;
     oneDay.start_time = 0;
     oneDay.ending_time = 0;
     return winner;
 }
 
  function getWinner_oneWeek() onlyOwner public payable returns(address){
     require ( oneWeek.ending_time > block.timestamp, "currently not opening lottery" );  
     uint index = getRandom() % oneWeek.participants.length;    // To find the index value. Ex: 123 % 5 answer will be smaller than 5.
     address payable winner = oneWeek.participants[index];    // declare the winner.
     uint prize = oneWeek.total_price;   
     winner.transfer(prize);      // transfer total price to winner.
     delete oneWeek.participants;  // delete this dynamic array
     oneWeek.total_price = 0;
     oneWeek.start_time = 0;
     oneWeek.ending_time = 0;
     return winner;
 }
 
  function getWinner_oneMonth() onlyOwner public payable returns(address){
     require ( oneMonth.ending_time > block.timestamp, "currently not opening lottery" );  
     uint index = getRandom() % oneMonth.participants.length;    // To find the index value. Ex: 123 % 5 answer will be smaller than 5.
     address payable winner = oneMonth.participants[index];    // declare the winner.
     uint prize = oneMonth.total_price;   
     winner.transfer(prize);      // transfer total price to winner.
     delete oneMonth.participants;  // delete this dynamic array
     oneMonth.total_price = 0;
     oneMonth.start_time = 0;
     oneMonth.ending_time = 0;
     return winner;
 }
 
 function getAllValues_oneDay() public view returns(uint, uint, uint, uint){
     return (oneDay.participants.length, oneDay.start_time, oneDay.ending_time, oneDay.total_price);
 }
 
  function getAllValues_oneWeek() public view returns(uint, uint, uint, uint){
     return (oneWeek.participants.length, oneWeek.start_time, oneWeek.ending_time, oneWeek.total_price);
 }
 
  function getAllValues_oneMonth() public view returns(uint, uint, uint, uint){
     return (oneMonth.participants.length, oneMonth.start_time, oneMonth.ending_time, oneMonth.total_price);
 }
 
    
}