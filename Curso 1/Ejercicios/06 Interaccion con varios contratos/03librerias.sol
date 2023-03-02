// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

library Operaciones
{

    function dividir(uint _i, uint _j) public pure returns(uint)
    {
        require(_j>0, "no se puede dividir por 0");
            return _i / _j;
    }

    function multiplicar(uint _i, uint _j) public pure returns(uint)
    {
        if ( _i==0 || _j==0 )
        {
            return 0;
        }
        else
        {
            return _i*_j;
        }
    }

}

contract calculo 
{
    using Operaciones for uint;

    function calculos(uint _a, uint _b) public pure returns(uint,uint)
    {
        uint q = _a.dividir(_b);
        uint m = _a.multiplicar(_b);

        return (q,m);
    }
}