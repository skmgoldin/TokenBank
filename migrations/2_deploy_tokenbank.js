const TokenBank = artifacts.require("./TokenBank.sol");

module.exports = function(deployer) {
  deployer.deploy(TokenBank, 0, "Bushwick Network Coin", 2, "BUSH", 10000000000000000);
};
