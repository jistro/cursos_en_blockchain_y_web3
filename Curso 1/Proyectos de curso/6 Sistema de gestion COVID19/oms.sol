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

    /*
    array de direcciones de los centros de 
    salud que tienen permisos para usar el smart contract
    */
    address[] public direccionesContratosCentrosSalud;

    // eventos para la gestion de los centros de salud
    event evento_NuevoContratoCentroSalud(address direccionContratoCentroSalud);
    event evento_CentroSaludValidado(address direccionContratoCentroSalud);

    // modificacior que permita solo a la OMS ejecutar la funcion
    modifier soloOMS() {
        require(msg.sender == OMS, "Solo la OMS puede ejecutar esta funcion");
        _;
    }
    // funcion para validar nuevos centros de salud que puedan autoregistarse
    // factory para crear nuevos contratos de centros de salud



}
