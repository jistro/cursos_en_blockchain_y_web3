const Calificacion = artifacts.require("Calificacion");

module.exports = function (deployer) {
    deployer.deploy(Calificacion);
};