// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract valoresDeRetorno
{
    
    function multiplica(uint _a, uint _b) public returns(uint)
    {
        return _a*_b;
    }

    function par_o_non(uint _a) public returns(bool)
    {
        bool flag;
        if (_a%2 == 0)
        {
            flag = true;
        }
        else 
        {
            flag = false;
        }
        return flag;
    }

    function divicion(uint _a, uint _b) public returns(uint,uint,bool)
    {
        uint q = _a/_b;
        uint r = _a%_b;
        bool multiplo;
        if (r==0)
        {
            multiplo = true;
        }
        else 
        {
            multiplo = false;
        }

        return (q,r,multiplo);
    }

    function numeros() public returns (uint, uint, uint, uint)
    {
        return (1,2,3,4);
    }
    function todosValores() public 
    {
        uint a; uint b; uint c; uint d;
        (a,b,c,d)=numeros();
    }
    function ultimoValor() public
    {
        (,,,uint ultimo)=numeros();
    } 

}