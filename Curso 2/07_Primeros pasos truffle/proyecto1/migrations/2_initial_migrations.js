const Hello = artifacts.require("Hello");

// Se exporta la función deployer para que pueda ser utilizada por Truffle
// Se despliega el contrato Hello
module.exports = function (deployer) {
    deployer.deploy(Hello);
};