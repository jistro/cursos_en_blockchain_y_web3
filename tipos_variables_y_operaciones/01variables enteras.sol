// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract enteros 
{
    uint sinSigno;
    uint sinSgnoDeclarado = 4;
    uint cota = 5000;

    //num. especifico de bits
    uint8   entero8Bits;
    uint64  entero64Bits = 7000;
    uint16  entero16Bits;
    uint256 entero256Bits;

    int conSigno;
    int conSignoDeclarado = -32;

    //num. especifico de bits
    int8    signo8bits;
    int72   signo72Bits;
    int240  signo240Bits = 90000;
    int256  signo256Bits;

}