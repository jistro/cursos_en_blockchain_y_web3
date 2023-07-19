// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.6.0;

// con versiones anteriores a 0.8.0
// se tenia que importar la libreria SafeMath.sol
// pero ahora ya esta incluida en el compilador
// por lo que no es necesario importarla
// ensenar overflow con versiones anteriores a 0.8.0
// despues usar la version 0.8.0

contract SafeMathTester {
    uint8 public numero = 255;
    function incrementar() public {
        numero++;
        // si no queremos usar el safeMath instalado por defecto
        // en la version 0.8.0
        // podemos usar unchecked {numero++;}
    }
}