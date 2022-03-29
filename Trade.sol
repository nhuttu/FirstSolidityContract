// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
contract Trade {
    address payable public sender; // the initializer
    address payable public recipient; // person who receives
    uint256 public expirationTime; // expiration time

    constructor (address payable recipientsAddress, uint256 duration)  payable { // the constructor
        sender = payable(msg.sender); // we assign that the sender pays with payable and msg.sender
        recipient = recipientsAddress; // we save the recipient's address
        expirationTime = block.timestamp + duration; // expiration time
    }
    function RecipientCloseTheTrade(uint256 amount) external { // recipient withdraws
        require(msg.sender == recipient, "You are not the recipient!"); // checks that if the recipient is the one trying to withdraw
        recipient.transfer(amount); // if above happens, this executes
        selfdestruct(sender); // contract self destructs and the remaining money is sent back to the sender
    }
    function ExtendTimer(uint256 newExpirationTime) external { // extend duration of the contract
        require(msg.sender == sender, "You are not the sender!"); // only sender can extend it
        require(newExpirationTime > expirationTime, "New expiration time is not older than the last one"); // has to be a larger number than the previous existing duration
        expirationTime = newExpirationTime; // new expiration is put in to place
    }
    function SenderClosesChannel() external { // sender gets his money back
        require(block.timestamp >= expirationTime, "Expiration not over yet!"); // if the recipient is inactive, the sender can claim his money back
        selfdestruct(sender); // the contract self destructs and returns the money to the sender
    }
    //getter 
    function getSender() public view returns (address ) {
        return sender;
    }
    //getter
    function getRecipient() public view returns (address ) {
        return recipient;
    }
    //getter
    function getExpirationTime() public view returns (uint) {
        return expirationTime;
    }
}
