// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;


contract view_pure_payable 
{
    
    string[] listaALumnos;

    function nuevo_alumno(string memory ALUMNO) public 
    {   
        listaALumnos.push(ALUMNO);
    }
    function visualiza_alumno(uint POSCICION) public view returns (string memory)
    {
        return listaALumnos[POSCICION];
    }

    uint x = 10;
    function sumar_a_x(uint A) public view returns (uint)
    {
        return (A+x);
    }

    function exp (uint A, uint B) public pure returns(uint)
    {
        return A**B;
    }

    //Uso del modificador payable
    mapping (address=>cartera) DineroCartera;
    struct cartera
    {
        string nombrePersona;
        address walletPersona;
        uint dinero;
    }
    function pagar(string memory NOMBREPERSONA, uint CANTIDAD) public payable 
    {
        cartera memory mi_cartera;
        mi_cartera = cartera(NOMBREPERSONA, msg.sender, CANTIDAD);
        DineroCartera[msg.sender] = mi_cartera;
    }

    function ver_saldo() public view returns(cartera memory)
    {
        return DineroCartera[msg.sender];
    }

}