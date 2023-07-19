const OracleNasa = artifacts.require("OracleNasa");

module.exports = function(deployer) {
    deployer.deploy(OracleNasa);
};