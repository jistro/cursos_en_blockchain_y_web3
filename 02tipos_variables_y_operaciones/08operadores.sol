// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 < 0.7.0;

contract operadores 
{
    uint a = 32;
    uint b = 4;
    uint c = 3;
    uint d = 3;

    uint public suma        = a+b;
    uint public resta       = a-b;
    uint public dividir     = a/b;
    uint public modulo      = a%b;
    uint public multiplicar = a*b;
    uint public exponencia  = a**b;

    bool public mayorQue        = a>b;
    bool public menorQue        = a<b;
    bool public igualQue        = c==d;
    bool public mayorIgualQue   = a>=b;
    bool public menorIgualQue   = a<=b;
    bool public diferenteQue    = a!=b;

    //define si este es año bisiesto o no
    function biciesto(uint _anno) public pure returns(bool)
    {
        if ((_anno%4==0) && (_anno%100!=0) || (_anno%400==0))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}