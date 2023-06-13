// SPDX-License-Identifier:  MIT
pragma solidity ^0.8.9;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


// me quede en este video https://www.youtube.com/watch?v=gyMwXuJrbJQ en el minuto 4:20:10
// ya quiero dormir :(
contract fundme {

    uint256 public minimumUSD = 50;

    function getPrice() public view returns (uint256) {
        // abi of contract
        // address contract 0x5498BB86BC934c8D34FDA08E81D444153d0D06aD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x5498BB86BC934c8D34FDA08E81D444153d0D06aD);
        (, int price, , , )=priceFeed.latestRoundData();
        return uint256(price * 1e18);


        
    }
    function getConvertionRate(uint ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();
        // 3000_00000000000000000 = eth / usd price
        //   1_000000000000000000 = 1 eth

        uint256 ethToUSD = (ethPrice * ethAmount) / 1e18;
        return ethToUSD;
    }
    //recordar que el contrato guarda el eth 
    function fund() public payable {
        // msg es una variable global que tiene informacion del usuario que esta interactuando con el contrato
        // msg.sender es la direccion del usuario que esta interactuando con el contrato
        // msg.value es la cantidad de eth que esta enviando el usuario
        require(msg.value >= 1e18, "haz enviado menos de 1 eth"); // 1 ether == 1e18 wei == 1000000000000000000 wei
    }

    function withdraw() public payable {
        // msg.sender es la direccion del usuario que esta interactuando con el contrato
        // msg.value es la cantidad de eth que esta enviando el usuario
        require(msg.sender == 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, "no eres el dueño del contrato");
        payable(msg.sender).transfer(address(this).balance);
    }




}