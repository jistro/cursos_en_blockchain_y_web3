// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "./ERC20.sol";

contract Disney {



//---------------------------Declaraciones Iniciales--------------------------------------//

    // instancia del contrato token
    ERC20Disney private tokensDisney;

    // direccion de disney (owner)
    address payable public owner;


    // constructor
    constructor(){
        tokensDisney = new ERC20Disney(1000);
        owner = payable(msg.sender);
    }

    // estructura de datos para almacenar a los clientes de Disney
    struct cliente {
        uint tokensComprados;
        string [] atraccionesDisfrutadas;
    }

    // mapping para el registro de clientes
    mapping (address => cliente) public Clientes;




//----------------------------------------------------------------------------------------//

//---------------------------------Gestion de tokens--------------------------------------//

    // funcion para establecer precio de un token 
    function PrecioTokens(uint _numTokens) internal pure returns(uint) {
        // convercion 1:1 de tokens <=> eth
        return _numTokens * (1 ether);
    }

    // compra de tokens para uso de atracciones
    function compraTokens(uint _numTokens) public payable {
        // Establecer precio de tokens 
        uint coste = PrecioTokens(_numTokens);

        // se evalua el dinero que el cliente paga por los tokens
        require(msg.value >= coste, "No se puede comprar esta cantidad, compra menos o usa mas ETH");

        // diferencia de lo que el cliente paga
        uint returnValue = msg.value - coste;

        // disney retorna la cantidad de ETH al cliente
        payable(msg.sender).transfer(returnValue);

        // obtencion del num. de tokens disponible
        uint Balance = balanceOf();
        require(_numTokens <= Balance, "Lo sentimos, no hay disponible mas de la cantidad que pidio");

        // se transfiere el num. de tokens solicitados al cliente
        tokensDisney.transfer(msg.sender, _numTokens);

        // registero de tokens comprados
        Clientes[msg.sender].tokensComprados = _numTokens;

    }

    // balance de tokens del contrato
    function balanceOf() public view returns(uint){
        return tokensDisney.balanceOf(address(this));
    } 

    // visualizar el num de tokens de un cliente

    function misDisneyDollars() public view returns(uint){
        return tokensDisney.balanceOf(msg.sender);
    }

    // funcion para generar mas tokens

    function mintMoreTokens(uint _numTokens) public Unicamente(msg.sender){
        tokensDisney.mint(_numTokens);
    } 

    // modificador para permitir el acceso solo al que lanza el contrato (disney)
    modifier Unicamente(address _direccion){
        require(_direccion == owner, "NO tienes permisos para ejecutar");
        _;
    }
    


//----------------------------------------------------------------------------------------//

//---------------------------------------Gestion de disney--------------------------------//

    // ---|eventos|--- // 

    event Evento_acceso_a_atraccion(string);
    event Evento_nueva_atraccion(string mensaje, string atraccion, uint coste);
    event Evento_baja_atraccion(string nombre, string motivo);
    event Evento_alta_atraccion(string nombre, string motivo);
    
    // estructura de la atraccion

    struct experiencia {
        string  nombre;
        uint    precio;
        bool    estado;
    }

    // maping para relacion de nomre de una atraccion con una estructura de datos de la atraccion

    mapping (string => experiencia) public Mapping_atraccion;
    

    //array para almacenar los nombres de las atracciones
    string [] atracciones;


    //mapping para almacenar historial de exeriencias con cda. cliente
    mapping (address => string[]) HistorialAtracciones;

    //crea nuevas atraciones para disneyland--solo ejecutable por el autor del contrato
    function crearAtracciones(string memory _nombreAtraccion, uint _coste) public Unicamente(msg.sender){
        // creamos atraccion
        Mapping_atraccion[_nombreAtraccion] = experiencia(_nombreAtraccion, _coste, true);
        // almacenamos en el array de atracciones
        atracciones.push(_nombreAtraccion);
        // Emitimos evento
        emit Evento_nueva_atraccion("Atencion, nueva atraccion en disneyland!! ",_nombreAtraccion,_coste);
    }

    // funcion de baja de atraccion
    function bajaAtraccion(string memory _nombreAtraccion, string memory _motivo) public Unicamente(msg.sender){
        // verificaos que esta atraccion si exista
        require(Mapping_atraccion[_nombreAtraccion].precio > 0, "esta atraccion no esta registrada");
        //el estado pasa a False el cual indica que esta a desuso
        Mapping_atraccion[_nombreAtraccion].estado=false;
        // emitimos la baja
        emit Evento_baja_atraccion(_nombreAtraccion,_motivo);
    }

    //funcion de alta a atraccion
    function altaAtraccion(string memory _nombreAtraccion, string memory _motivo) public Unicamente(msg.sender){
        // verificaos que esta atraccion si exista
        require(Mapping_atraccion[_nombreAtraccion].precio > 0, "esta atraccion no esta registrada");
        //el estado pasa a False el cual indica que esta a desuso
        Mapping_atraccion[_nombreAtraccion].estado=true;
        // emitimos la baja
        emit Evento_alta_atraccion(_nombreAtraccion,_motivo);
    }

    function verAtraccionesDisponibles() public view returns (string[] memory) {
        return atracciones;
    }

    function pagoTickets(string memory _nombreAtraccion) public payable {
        //verifica si existe
        require(Mapping_atraccion[_nombreAtraccion].precio > 0, "Verifique si escribio bien o si existe");
        // verifica si esta disponible
        require(Mapping_atraccion[_nombreAtraccion].estado, "esta atraccion no esta disponible por el momento");
        // almacena coste de atraccion
        uint costo_perTicket_atraccion = Mapping_atraccion[_nombreAtraccion].precio;
        //verifica si 
        require(misDisneyDollars() >= costo_perTicket_atraccion, "lo sentimos no tiene la cantidad de DYD para comprar un ticket");
        // realiza el pago y envia el token a el owner
        tokensDisney.transferFrom(msg.sender, owner, costo_perTicket_atraccion);
    }

}




