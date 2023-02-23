// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;

contract CausasBeneficas
{

    struct Causa
    {
        uint id;
        string nombre;
        uint precioObjetivo;
        uint cantidadRecaudda;
    }mapping (string => Causa) Causas;

    uint contadorAsignaId = 0;
    
    // permite dar de alta a la ong
    function alta_a_causa(string memory NOMBRE, uint PRECIO_OBJETIVO) public payable 
    {

        contadorAsignaId = contadorAsignaId++;

        Causas[NOMBRE] = Causa( contadorAsignaId, 
                                NOMBRE, 
                                PRECIO_OBJETIVO, 
                                0);

    }

    // indica a la ong si ha llegado a la meta
    function meta_cumplida_causa(string memory NOMBRE, uint DONAR) private view returns(bool)
    {
        bool flagMeta = false;
        Causa memory causa = Causas[NOMBRE];
        
        if ( causa.precioObjetivo >= (causa.cantidadRecaudda + DONAR) ) 
        {
            flagMeta = true;
        } 
        else 
        {
            flagMeta = false;
        }
        return flagMeta;
    }

    // permite al usuario donar a la ong
    function donar_a_causa(string memory NOMBRE, uint CANTIDAD) public returns(bool)
    {
        bool flagAceptarDonacion = true;
        
        if ( meta_cumplida_causa(NOMBRE, CANTIDAD) )
        {
            Causas[NOMBRE].cantidadRecaudda = Causas[NOMBRE].cantidadRecaudda + CANTIDAD;
        }
        else 
        {
            flagAceptarDonacion = false;
        }

        return  flagAceptarDonacion;

    }

    // Nos dice si hemmos llegado a la meta
    function comprobar_causa(string memory NOMBRE) public view returns(bool, uint)
    {
        bool flagMetaLograda = false;

        Causa memory causa = Causas[NOMBRE];

        if (causa.cantidadRecaudda == causa.precioObjetivo)
        {
            flagMetaLograda = true;
        }

        return (flagMetaLograda, causa.cantidadRecaudda);
    }
}