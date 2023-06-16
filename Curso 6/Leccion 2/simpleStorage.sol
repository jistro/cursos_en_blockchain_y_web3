// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract simpleStorage {
    // this will get initialized to 0!
    // by default, the value of an uninitialized uint is 0 and is internal 
    struct persona {
        uint8 edad;
        string nombre;
        int numeroFavorito;
    }

    persona public amigo = persona(18, "Juan", 7);

    //memory es para variables temporales que se pueden modificar
    //calldata es para variables temporales que no se pueden modificar
    //storage es para variables que se guardan en la blockchain
    function cambiarDatosAmigo(uint8 _edad, string memory _nombre, int _numeroFavorito) public {
        amigo.edad = _edad;
        amigo.nombre = _nombre;
        amigo.numeroFavorito = _numeroFavorito;
    }

    function obtenerDatosAmigo() public view returns (uint8, string memory, int) {
        return (amigo.edad, amigo.nombre, amigo.numeroFavorito);
    }

    persona[] public listaAmigos;

    function agregarAmigo(uint8 _edad, string memory _nombre, int _numeroFavorito) public {
        persona memory nuevoAmigo = persona(_edad, _nombre, _numeroFavorito);
        listaAmigos.push(nuevoAmigo);
    }

    function obtenerAmigo(uint _indice) public view returns (uint8, string memory, int) {
        persona memory amigoAux = listaAmigos[_indice];
        return (amigoAux.edad, amigoAux.nombre, amigoAux.numeroFavorito);
    }

    function obtenerNumeroAmigos() public view returns (uint) {
        return listaAmigos.length;
    }

    function obtenerAmigos() public view returns (persona[] memory) {
        return listaAmigos;
    }

    mapping (string => persona) public mapeoAmigos;

    function agregarAmigoMapping(string memory _nombre, uint8 _edad, int _numeroFavorito) public {
        persona memory nuevoAmigo = persona(_edad, _nombre, _numeroFavorito);
        mapeoAmigos[_nombre] = nuevoAmigo;
    }

    function obtenerAmigoMapping(string memory _nombre) public view returns (uint8, string memory, int) {
        persona memory amigoAux = mapeoAmigos[_nombre];
        return (amigoAux.edad, amigoAux.nombre, amigoAux.numeroFavorito);
    }
    
}
