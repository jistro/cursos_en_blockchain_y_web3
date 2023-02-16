// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract casteo 
{
    
    uint8 entero8Bits = 42;
    uint64 entero64Bits = 6000;
    uint enteroNormal = 1000000;

    int16 enteroCnSigno16bits = 156;    
    int120 enteroCnSigno120bits = 900000;
    int enteroCnSignoNormal = 5000000;

    uint64 public casteoUno     = uint64(entero8Bits);
    uint64 public casteoDos     = uint64(enteroCnSignoNormal);
    uint8  public casteoTres    = uint8 (enteroCnSigno16bits);
    int    public casteoCuatro  = int   (enteroNormal);
    int    public casteoCinco   = int   (entero64Bits);

    function convertir (uint8 _transformar) public view  returns(uint64)
    {
        return  uint64(_transformar);
    }

}