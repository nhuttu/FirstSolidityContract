# FirstSolidityContract

My first ever written Solidity smart contract. A simple payment channel between two wallets. Contract's constructor takes in two parameters, recipient's address and the duration which the contract is valid. Sender is the one who initalizes the contract by depositing an unspecified amount of ether. Variable expirationTime is block.timestamp + duration.

Now for the functions. If a sender wishes to withdraw his funds due to an inactive recipient, he can do that after the contract's expiration time is smaller or equal to block.timestamp (current block timestamp as seconds since unix epoch). Sender receives the funds via the selfdestruct function. If the time is not up, an error explaining this will be returned. 

If he wishes to extend the timer, he may also do that. The function requires that it is truly the sender extending the timer and no one else. Also the new expirationTime has to be bigger than the already existing one. 

Last function is the one how the recipient gets ahold of the funds. The function checks that the recipient is the on calling it. It takes in a parameter "amount" which is an unsigned integer. So it is the recipient's responsibility to withdraw the amount he wishes to. NB: the number is wei, so e.g. to withdraw 1 ether, you have to pass in 10^18 as the parameter. If the recipient doesn't withdraw the full amount, the rest is sent to the buyer via the selfdestruct function.

Last but not least there are getter functions for the 3 variables that we assert in the beginning of the contract. These are public functions so by nature anyone can call them.

