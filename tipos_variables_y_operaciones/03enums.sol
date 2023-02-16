// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract ejemplosEnumeracion 
{
    //enumeracion de interruptor
    enum estado {ON,OFF}   
    /* recordar que 
    ON  es el indice 0
    OFF es el indice 1
    */

    //invocando el enum
    estado interruptor;

    function encender() public
    {
        interruptor = estado.ON;
    }

    function apagar(uint _k) public 
    {
        interruptor = estado(_k);
    }

    function devolder_datos() public view returns(estado)
    {
        return interruptor;
    }

    //enumeracion de direcciones
    enum direcciones {ARRIBA, ABAJO, DERECHA, IZQUIERDA}

    direcciones movimiento = direcciones.ARRIBA;

    function arriba() public 
    {
        movimiento = direcciones.ARRIBA;
    }

    function abajo() public 
    {
        movimiento = direcciones.ABAJO;
    }
    function derecha() public 
    {
        movimiento = direcciones.DERECHA;
    }
    function izquierda() public 
    {
        movimiento = direcciones.IZQUIERDA;
    }
    function hacerMovimiento (uint _i) public 
    {
        movimiento = direcciones(_i);
    }
    function mostrarMovimiento() public view returns(direcciones)
    {
        return movimiento;
    }
}