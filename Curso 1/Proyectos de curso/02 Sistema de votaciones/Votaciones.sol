// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.7.0;
pragma experimental ABIEncoderV2;


/*
Finjamos que el INE nos mando a crear un sistema de votacion digital
usando blockchain por lo tanto tendremos un nuevo padron electoral digital
Orden de la tabla de datos
    --------------------------------------
    | Candidato | Edad | ID INE |Partido |
    --------------------------------------
    |    Toni   |  20  | TO2334 | MORENA |
    |  Alberto  |  40  | AL3322 |  PRI   |
    |    Ana    |  25  | AN4345 |  PAN   |
    --------------------------------------
*/
contract Votacion
{
    //Funcion auxiliar que transforma un uint a un string
    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    //Direccion del propietario del contrato
    address public owner;

    //indicamos quien despliega el contrato mediante un constructor
    constructor() public 
    {
        owner = msg.sender;
    }

    //relacion entre nombre de candidato y hash de datos personales
    mapping(string=>bytes32) IDCandidato;

    //relacion entre nombre de candidato y numero de votos
    mapping (string => uint) VotosCandidato;

    //lista de candidatos
    string[] ListaNombresCandidatos;

    //padron electoral
    bytes32[] HashINEVotante;

    //Da de alta a los candidatos
    function Alta_Candidato(string memory _nombre, uint8 _edad, string memory _CodigoINE, string memory _partido) public
    {
        //calculamos el hash del candidato
        bytes32 HashIDCandidato = keccak256( abi.encodePacked( _nombre,_edad,_CodigoINE,_partido) );
        //almacenamos el hash del candidato ligado a el nombre de este
        IDCandidato[_nombre] = HashIDCandidato;

        //almacenamos el nombre del candidato 
        ListaNombresCandidatos.push(_nombre);
    }  


    //ver lista de candidatos
    function Ver_Lista_Candidatos() public view returns(string[] memory)
    {
        //devuelve lista de candidatos presentados
        return(ListaNombresCandidatos);
    }

    //permite votar por un candidato
    function Votar_Candidato(string memory _nombreCandidato) public 
    {
        //almacena hash de votante para verificar en padron
        bytes32 hashVotante = keccak256(abi.encodePacked( msg.sender ));
        //verificamos si el votante ya ha votado
        for (uint VotanteNum; VotanteNum<HashINEVotante.length;VotanteNum++)
        {   
            require(HashINEVotante[VotanteNum] != hashVotante, "ya has votado, gracias por tu participacion");
        }
        //almacenamos hash del votante dentro del padron de votantes
        HashINEVotante.push(hashVotante);
        VotosCandidato[_nombreCandidato]++;
    }

    //Podemos ver la cantidad de votos por candidato
    function Ver_Votos(string memory _nombreCandidato) public view returns(uint)
    { return (VotosCandidato[_nombreCandidato]); } 

    function Hacer_Corte() public view returns(string memory)
    {
        //guardamos en una variable los candidatos con sus respectivos votos
        string memory resultados="";

        for ( uint num=0; num < ListaNombresCandidatos.length ;num++)
        {
            resultados = string(abi.encodePacked(resultados, "(", ListaNombresCandidatos[num], " votos: ", uint2str( Ver_Votos( ListaNombresCandidatos[num] ) ) ));
            return(resultados);
        }
    }

    function Ganador_Por_Votos() public view returns(string memory)
    {
        string memory ganador=ListaNombresCandidatos[0];
        bool flagEmpate=false;

        for (uint i=0; i < ListaNombresCandidatos.length ;i++ )
        {
            if (VotosCandidato[ganador] < VotosCandidato[ListaNombresCandidatos[i]])
            {
                ganador = ListaNombresCandidatos[i];
                flagEmpate=false;
            }
            else 
            {
                if (VotosCandidato[ganador] == VotosCandidato[ListaNombresCandidatos[i]])
                {
                    flagEmpate=true;
                }
                else 
                {
                    flagEmpate=false;
                }
            }
        }
        if (flagEmpate)
        {
            ganador="Empate";
        }
        return(ganador);
    }
}