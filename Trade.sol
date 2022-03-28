// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;
contract Trade {
    address payable public sender;
    address payable public recipient;
    uint256 public expirationTime;

    constructor (address payable recipientsAddress, uint256 duration)  payable {
        sender = payable(msg.sender);
        recipient = recipientsAddress;
        expirationTime = block.timestamp + duration;
    }
    function RecipientCloseTheTrade(uint256 amount) external {
        require(msg.sender == recipient, "You are not the recipient!");
        recipient.transfer(amount);
        selfdestruct(sender);
    }
    function ExtendTimer(uint256 newExpirationTime) external {
        require(msg.sender == sender, "You are not the sender!");
        require(newExpirationTime > expirationTime, "New expiration time is not older than the last one");
        expirationTime = newExpirationTime;
    }
    function SenderClosesChannel() external {
        require(block.timestamp >= expirationTime, "Expiration not over yet!");
        selfdestruct(sender);
    }
    function getSender() public view returns (address ) {
        return sender;
    }
    function getRecipient() public view returns (address ) {
        return recipient;
    }
    function getExpirationTime() public view returns (uint) {
        return expirationTime;
    }
}
