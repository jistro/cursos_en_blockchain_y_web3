// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
pragma experimental ABIEncoderV2;

contract OMS_COVID {
    // Direccion de la OMS (Organizacion Mundial de la Salud)
    address public OMS;

    // Creacion del constructor del contrato
    constructor() {
        // Asignacion de la direccion del contrato a la variable OMS    
        OMS = msg.sender;
    }

    /* 
    mapping para relacionar los centros de  salud con la 
    validez del sistema de gestion 
    */
    mapping(address => bool) public mapping_validaciionCentroSalud;
    // si es true, el centro de salud tiene permisos para usar el smart contract
    // si es false, el centro de salud no tiene permisos para usar el smart contract
    // Relacionar una direccion de un centro de salud con su contrato
    mapping(address => address) public mapping_direccionCentroSaludContrato;
    /*
    array de direcciones de los centros de 
    salud que tienen permisos para usar el smart contract
    */
    address[] public direccionesContratosCentrosSalud;

    // array de direcciones para solicitar acceso al sistema de gestion
    address[] direccionesSolicitudesAcceso;

    // eventos para la gestion de los centros de salud
    event evento_NuevoContratoCentroSalud(address direccionContratoCentroSalud);
    event evento_CentroSaludValidado(address direccionContratoCentroSalud);
    event evento_SolicitudAcceso(address direccionCentroSalud);

    // modificacior que permita solo a la OMS ejecutar la funcion
    modifier soloOMS() {
        require(msg.sender == OMS, "Solo la OMS puede ejecutar esta funcion");
        _;
    }

    //duncion para solicitar acceso al sistema de gestion
    function CentroSaludSolicitarAcceso() public {
        // almacenamiento de la direccion del centro de salud
        direccionesSolicitudesAcceso.push(msg.sender);
        // emision del evento de solicitud de acceso
        emit evento_SolicitudAcceso(msg.sender);
    }

    // funcion para ver las direcciones de los centros de salud que solicitaron acceso solo para la OMS
    function OMS_verDireccionesSolicitudesAcceso() public view soloOMS() returns (address[] memory) {
        return direccionesSolicitudesAcceso;
    }

    // funcion para validar nuevos centros de salud que puedan autoregistarse
    function CentroSaludValidar(address _cenrtroSaludDireccion) public soloOMS() {
        // asignacion del estado de validez al centro de salud
        mapping_validaciionCentroSalud[_cenrtroSaludDireccion] = true;
        // emision del evento de validacion del centro de salud
        emit evento_CentroSaludValidado(_cenrtroSaludDireccion);
    }

    // factory para crear nuevos contratos de centros de salud
    function Factory_CentroDeSalud() public {
        // filtro para validar que el centro de salud tenga permisos para usar el smart contract
        require(mapping_validaciionCentroSalud[msg.sender], "El centro de salud no tiene permisos para usar el smart contract");
        // creacion del nuevo contrato de centro de salud (Factory)
        address contrato_centroSalud = address(new CentroDeSalud(msg.sender));
        // almacenamiento de la direccion del nuevo contrato de centro de salud
        direccionesContratosCentrosSalud.push(contrato_centroSalud);
        // Relacion entre centro de salud y contrato
        mapping_direccionCentroSaludContrato[msg.sender] = contrato_centroSalud;
        // emision del evento de creacion del nuevo contrato de centro de salud
        emit evento_NuevoContratoCentroSalud(contrato_centroSalud);
    }
}

////////////////////////////////////////////////////////////////////////////////////
// contrato de autogestion de los centros de salud
contract CentroDeSalud {
    // Direcciones iniciales para el desarrollo del smart contract
    address public DireccionCentroSalud;
    address public DireccionContrato;

    // Creacion del constructor del contrato
    constructor(address _direccionCentroSalud) {
        // Asignacion de la direccion del contrato a la variable DireccionCentroSalud
        DireccionCentroSalud = _direccionCentroSalud;
        // Asignacion de la direccion del contrato a la variable DireccionContrato
        DireccionContrato=address(this);
    }
    
    // mapping para relacionar a la persona con sus resulatdos (diagnostico, codigo IPFS)
    mapping (bytes32 => resultadosCOVID) ResultadosCOVID;

    // estructura para almacenar los resultados de las pruebas de covid
    struct resultadosCOVID {
        bool resultadoPruebaCovid;
        string codigoIPFS;
    }

    // eventos para la gestion de los centros de salud
    event evento_NuevoResultado(string codigoIPFS, bytes32 hashPersona, bool resultadoPruebaCovid); 

    // modificacior que permita solo a los centros de salud ejecutar la funcion
    modifier soloCentroSalud() {
        require(msg.sender == DireccionCentroSalud, "Solo el centro de salud puede ejecutar esta funcion");
        _;
    }

    // funcion que el centroi de salud emita un resultado de prueba de covid
    function ResultadoPruebaCovid(string memory _IDpersona, bool _resultadoPruebaCovid, string memory _codigoIPFS) public soloCentroSalud() {
        // creacion del hash de la persona
        /*
        1. convertir el ID de la persona en bytes
        2. convertir los bytes en un hash
        3. convertir el hash en bytes32
        */
        bytes32 hashPersona = keccak256(abi.encodePacked(_IDpersona));
        // relacion del hash de la persona con la estructura de resultados
        ResultadosCOVID[hashPersona] = resultadosCOVID(_resultadoPruebaCovid, _codigoIPFS);
        // emision del evento de nuevo resultado
        emit evento_NuevoResultado(_codigoIPFS, hashPersona, _resultadoPruebaCovid);
    }

    // funcion para que permita ver los resultados
    function verResultados(string memory _IDpersona) public view returns (string memory, string memory){
        // creacion del hash de la persona
        /*
        1. convertir el ID de la persona en bytes
        2. convertir los bytes en un hash
        3. convertir el hash en bytes32
        */
        bytes32 hashPersona = keccak256(abi.encodePacked(_IDpersona));
        //retorno de un booleano como un string
        if (ResultadosCOVID[hashPersona].resultadoPruebaCovid) 
        {
            return ("Positivo", ResultadosCOVID[hashPersona].codigoIPFS);
        } 
        else 
        {
            return ("Negativo", ResultadosCOVID[hashPersona].codigoIPFS);
        }
    }

} 