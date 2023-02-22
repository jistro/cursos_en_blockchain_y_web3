// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract tiempo 
{
    uint public tiempoActualDespliegue = now;
    uint public minuto = 1 minutes;
    uint public dosHoras = 2 hours;
    uint public cincoDias = 5 days;
    uint public semana = 1 weeks;

    function MasSegundos() public view returns(uint)
    {
        return now + 50 seconds;
    }
    
    function MasHoras() public view returns(uint)
    {
        return now + 1 hours;
    }

    function MasDias() public view returns(uint)
    {
        return now + 1 days;
    }

    function MasSemanas() public view returns(uint)
    {
        return now + 1 weeks;
    }

}