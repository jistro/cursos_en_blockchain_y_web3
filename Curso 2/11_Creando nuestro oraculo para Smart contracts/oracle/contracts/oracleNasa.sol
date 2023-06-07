// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract OracleNasa is Ownable {
    
    // direcccion de la api https://api.nasa.gov/neo/rest/v1/feed?start_date=START_DATE&end_date=END_DATE&api_key=API_KEY

    /// @dev Evento que se dispara cuando hay nuevos datos
    event __callbackNewData();

    /// @dev Permite ver el num de asteroides
    uint public numAsteroides;

    /// @dev Recibe datos del oraculo
    function update() public onlyOwner{
        emit __callbackNewData();
    }

    /// @dev  Funcion para configuracion manual del numero de asteroides
    function setNumAsteroides(uint _numAsteroides) public onlyOwner{
        numAsteroides = _numAsteroides;
    }

    

}