const CryptoCerts = artifacts.require("CryptoCerts");

module.exports = function (deployer) {
  deployer.deploy(CryptoCerts);
};
