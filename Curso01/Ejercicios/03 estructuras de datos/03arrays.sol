// SPDX-License-Identifier: MIT
pragma solidity ^0.4.0;

contract arrays 
{
    
    uint    [5]  public arrayFijoEnteros = [2,4,6];
    string  [15] arrayFijoStrings;
    uint32  [7]  arrayFijoEnteros32;

    uint    []   public arrayDinamicoEnteros;

    struct persona
    {
        string nombre;
        uint8 edad;
    }

    //declaracion de array usando struct
    persona [] public arrayDinamicoPersonas;

    function modificar_array(uint _num) public 
    {
        arrayDinamicoEnteros.push(_num);
    }
    function modificar_personas(string _nombre, uint8 _edad) public 
    {
        arrayDinamicoPersonas.push( persona(_nombre,_edad) );
    }
    
    function ver_numeros(uint _pos) public returns (uint) 
    {
        return arrayFijoEnteros[_pos];
    }
}