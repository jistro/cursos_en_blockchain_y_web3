// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract estructuras 
{
    struct producto
    {
        uint idProducto;
        string nombreProducto;
        uint precioUnitario;
    }    

    producto celular = producto(1223,"xiaomi",5100);

}