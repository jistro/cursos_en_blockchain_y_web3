// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;
contract funciones 
{
    //añadir dentro de un array de direcciones
    //la direccion de la persona que llame la funcion
    address[] public direcciones;
    function nuevaDireccion() public 
    {
        direcciones.push(msg.sender);
    }

    //computar el hash de los datos proporcionados
    //como paramentro 

    bytes32 public hash;

    function creaHash(string memory _datos) public 
    {
        hash = keccak256(abi.encodePacked(_datos));
    }

    struct comida
    {
        string comida;
        string ingredientes;
    }

    comida public hamburguesa;

    function hamburguesas(string memory _ingredientes) public 
    {
        hamburguesa = comida("hamburguesa", _ingredientes);
    }

    //en una escuela hay una lista, debemos crear el hash de ls datos
    //personales de los slumnos y de alli creamos una funcion publica para
    //mostrar los datos

    struct alumno
    {
        string nombre;
        address direccion;
        uint8 edad;
    }
    bytes32 public hash_id_alumno;
    //calcular el hash 
    function calcularHashId(string memory _getNombre, address _getDireccion, uint8 _getEdad) private 
    {
        hash_id_alumno = keccak256( abi.encodePacked( _getNombre,_getDireccion,_getEdad ) );
    }

    //guardamos con la funcion publica dentro de la lista los alumnos
    alumno[] public lista;

    mapping (string=>bytes32) alumnos;

    function nuevoAlumno(string memory _nombre, uint8 _edad) public 
    {
        lista.push(alumno(_nombre,msg.sender,_edad));
        calcularHashId(_nombre,msg.sender, _edad);
        alumnos[_nombre]= hash_id_alumno;
    }
}