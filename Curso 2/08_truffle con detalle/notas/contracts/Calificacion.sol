// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

/*
Los datos de las notas se almacenan de la siguiente manera
  -------------------------
 |Alumno|Matricula| Calif. |
  -------------------------
 |Jose  |202058953|   07   |
 |Luisa |201985244|   10   |
 |Mario |201752526|   08   |
  -------------------------
 */

contract Calificacion 
{
    //direccion del profesor 
    address public profesor;

    //especificamos el propietario del contrato
    //en este caso el profesor
    constructor () 
    {
        profesor = msg.sender;

    }
    
    /* mapping para relacionar hash de la identidad del
    alumno con la calificacion del examen */
    mapping(bytes32 => uint8) Calificaciones;

    //array de los alumnos que pidan reviciones de exmamen
    string[] revisiones;

    //Eventos//////////////////////////////

    event evento_alumno_evaluado(bytes32,uint8);
    event evento_revision(string);

    //funcion para registrar evaluacion de maestro a alumno
    function evaluar(string memory _matriculaAlumno, uint8 _calificacion) public SoloProfesor(msg.sender)
    {
        //Creamos hash de identificacion del alumno
        bytes32 hashIdAlumno = keccak256(abi.encodePacked(_matriculaAlumno));
        //relacion entre hash de identificacion y la nota
        Calificaciones[hashIdAlumno] = _calificacion;
        //emitimos evento 
        emit evento_alumno_evaluado(hashIdAlumno, _calificacion);
    }

    //control de las funciones ejecutables por el profesor
    modifier SoloProfesor(address _direccionAcceso)
    {
        //Requiere que la direccion  introducida por 
        //el parametro sea igual al creador del contrato

        require(_direccionAcceso == profesor, "solo el porfesor puede acceder");
        _;
    }

    //Funcion para ver notas de alumno
    function ver_notas(string memory _matriculaAlumno) public view returns(uint8)
    {
        bytes32 hashAlumno = keccak256(abi.encodePacked(_matriculaAlumno)); 
        //calificacion asociada al hash del alumno
        uint8 calificacionAlumno = Calificaciones[hashAlumno];
        //devolvemos la calificacion
        return(calificacionAlumno);
    }

    //Funcion para pedir una revision de calificacion
    function revision(string memory _matriculaAlumno) public 
    {

        bytes memory tempEmptyStringTest = bytes(_matriculaAlumno);
        require(tempEmptyStringTest.length != 0, "error: no hay datos ingresados");
        //Almacenamiento de la matricula del alumno en un array
        revisiones.push(_matriculaAlumno);
        //Emision del evento 
        emit evento_revision(_matriculaAlumno);
    }

    //Funcion para ver los alumnos que han solicitado revision
    function ver_revision() public view SoloProfesor(msg.sender) returns(string [] memory)
    {   
        //devolver matricula de alumnos que han solicitado revision
        return(revisiones);
    }
}