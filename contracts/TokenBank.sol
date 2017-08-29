pragma solidity ^0.4.11;

import "eip621-tokens/EIP621OraclizedToken.sol";

contract TokenBank {

  EIP621OraclizedToken token;
  uint price;

  function TokenBank(uint _initialAmount, string _tokenName, uint8 _decimalUnits,
                     string _tokenSymbol, uint _price) {
    token = new EIP621OraclizedToken(_initialAmount, _tokenName, _decimalUnits, _tokenSymbol, this);
    price = _price;
  }

  function purchaseTokens() public payable {
    uint purchaseAmount = msg.value / price;
    uint extra = msg.value % price;

    if(extra != 0) {
      msg.sender.transfer(extra);
    }

    token.increaseSupply(purchaseAmount, msg.sender); 
  }

  function redeemTokens(uint _amount) public {
    token.transferFrom(msg.sender, this, _amount);
    token.decreaseSupply(_amount, this);

    msg.sender.transfer(_amount * price);
  }
}

