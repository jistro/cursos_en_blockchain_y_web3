# Cosas necesarias para de desarrollo de contratos inteligentes en  Etehreum

- Lenguaje de desarrollo: solidity

- Wallet: MetaMask, Exodus, etc.

- Entorno de desarrollo (IDE): Remix IDE

- Sistema de almacenamiento: InterPlanetary File System (IPFS)

- Etherscan: para visualizar transacciones, bloques y mineros
  ![Gráfico de los necesario en  desarrollo de contratos en ETH](./img/01_img1.png "Gráfico de los necesario en  desarrollo de contratos en ETH")
  
  # Solidity
  
  Solidity es un lenguaje de alto nivel enfocado a contratos inteligentes. Su sintaxis es similar a JavaScript y está enfocado específicamente a la Máquina Virtual de Etehereum (EVM).
  Solidity está tipado de manera estática y acepta, entre otras cosas, herencias, librerías y tipos complejos definidos por el usuario.
  Como verá, es posible crear contratos para votar, para el crowdfunding, para subastas a ciegas, para monederos muti firmas, y mucho más.
  
  # Primeros pasos de desarrollo
  
  ## Versión del compilador
  
  `pragma solidity <version>;`
  Con este definimos el tipo de versión que se compilara el contrato, este es de suma importancia ya que algunas versiones de compilación de solidity pueden hacer que el contrato actué de una manera inesperada afectando las transacciones del sistema 
  Existen dos maneras de declarar la versión
  `pragma solidity ^0.4.0;`
  Este define que la versión de compilación debe se mayor o igual a la indicada en hasta x.x.9
  `pragma solidity >=0.4.0 <0.7.0;`
  Definimos un rango especifico del compilado del sistema
  
  ## Función "contract"
  
  ```solidity
  contract <nombre>
  {
    ...
  }
  ```
  
  es nuestro main o cambien funciones de programación del programa

## Función "constructor"

```solidity
constructor() public
{ 
    ...
}
```

Define las propiedades del contrato, este es completamente opcional ya que solidity lo construye por defecto
Inicializa las variables de estado del contrato, estas se almacenan en el storage del contrato
**Se indican una sola vez cuando desplegamos el contrato**

## Comentarios del código

```solidity
//Una linea
/* 
Multiples lineas
*/
```

Es obvio la función de este pero en el caso de desplegar contratos inteligentes estos cumplen una función especifica un estándar

### Formato NatSpec

Este sirve para documentar el contrato inteligente de una manera estandarizada
Se especifica la licencia del código que por motivos obvios esto va fuera del alcance del cursos
después especificamos ciertas cosas como 
`@title` Describe el contrato
`@author` Nombra al autor del contrato
`@notice` explica al usuario final que hace el contrato
`@dev` Explica al desarrollador de ciertas cosas a tener en cuenta
`@param` Documenta los parámetros/variables del contrato
`@return` Documenta el valor de los parámetros de retorno

a continuación podemos observar un ejemplo del formato NatSpec

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;


/// @author Blockchain Knowledge Team
/// @title Demo Contract
contract DemoContract 
{
   uint storedData;

   /// Store \`x\`.
   /// @param x the new value to store
   /// @dev stores the number in the state variable \`storedData\`
   function set(uint x) public 
   {
       storedData = x;
   }

   /// Return the stored value.
   /// @dev retrieves the value of the state variable \`storedData\`
   /// @return the stored value
   function get() public view returns (uint) 
   {
       return storedData;
   }
}
```

## Propiedades de las transacciones y los bloques

Estas propiedades son un conjunto dé funciones globales que nos proporcionan ciertos datos de transacciones o del manejo de bloques en etehereum u otras side-chains

`block.blockhash(int)`Devuelve el hash de un bloque dado de los últimos 250 bloques
`block.coinbase` Devuelve la dirección del minero que esta minando el bloque actual
`block.difficulty` Devuelve la dificultad del bloque actual
**Atención**: Por el hecho de que etehereum paso a ser proof of stake es posible que las 2 anteriores funciones puedan estar descontinuadas
`block.gaslimit`Devuelve el limite de _gas_ del bloque actual
`block.number` Devuelve el núm. del bloque actual
`block.timestamp` Devuelve el timestamp del bloque actual en segundos siguiendo el tiempo universal de Unix
`msg.data` Devuelve los datos enviados en la transacción
`msg.gas` Devuelve el gas que queda en un numero entero
`msg.sender` Devuelve la dirección del remitente del call actual
`msg.sig` Devuelve los 4 primeros bytes de los datos enviados en la transacción
`msg.value` Devuelve un entero que contiene el núm. de _Wei_ enviado en la call
`now` Devuelve el timestamp del bloque actual en un entero, es un alias del `block.timestamp`
`tx.gasprice` Devuelve el costo del _gas_ de la transacción
`tx.origin` Devuelve el dato del emisor original de la transacción 

## Función keccak256()

Función criptográfica que realiza el computo del hash que se le de como parámetro, se basa en el algoritmo _SHA256_ SHA viene de Secure Hash Algorithm el numero 256 viene porque realiza un computo de 256 bits (32 bytes) 

`keccak256(<valores>);`

esta función espera que los valores que sean ingresados sean de tipo bites para ello nos auxiliamos de otra función `abi.encodePacked()` la cual toma una serie de argumentos y devuelve los bites

Para ello debemos poner antes del contrato

`pragma experimental ABIEncoderV2;`

```solidity
pragma experimental ABIEncoderV2;

contract <NAME>
{
    ...
    keccak256( abi.encodePacked(<valor>) );
    ...
}
```
