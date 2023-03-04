# Modificadores internal y external

Estos son modificadores están junto con `private` y `public`, cada uno de ellos cumplen un proceso diferente

## internal

Es algo parecido a `private`, solo se puede llamar desde el contrato actual o contratos hijos o externos 

```solidity
//ejemplo
function ingresar_datos() internal view returns(bool)
```

# external

Es bastante parecido a `public` Estas solo pueden ser llamadas desde contratos hijo o externos

```solidity
//ejemplo
function ingresar_datos() external view returns(bool)
```

# Función require

Es lo equivalente a un "_break_"  en cualquier lenguaje de programación pero para funciones, este al pasar por esta función verifica la condición de este, si resulta ser positivo, no hace nada y pasa a la siguiente, de ser negativo, lanza un mensaje que hemos escrito antes y para la ejecución completamente

```solidity
require (condicion, "mensaje condicion falsa");
```

cabe resaltar que no es necesario escribir el texto en el `require` para invocar el error haciendo que este se pueda ejecutar 

# Modifier

Esta función permite cambiar el comportamiento de una función

Este pasa por una función por lo general in `if` o un `require` para poder acceder a la función, para indicar en que parte se accede a la función se usa `_;` que indica que la función se puede acceder

```solidity
modifier nombreModificador(parametros)
{
    require(condicion);
    _;//indicamos que aqui comenzara a ejecutar el function
}

//como invocarlo (ejemplo)
function nombrefunction(...) ... [nombreModificador(parametros)] returns(...)
{
    ...
}
```

Ejemplo

```solidity
pragma solidity ^0.5.0;

contract Owner {
   address owner;
   constructor() public {
      owner = msg.sender;
   }
   modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }
   modifier costs(uint price) {
      if (msg.value >= price) {
         _;
      }
   }
}
contract Register is Owner {
   mapping (address => bool) registeredAddresses;
   uint price;
   constructor(uint initialPrice) public { price = initialPrice; }

   function register() public payable costs(price) {
      registeredAddresses[msg.sender] = true;
   }
   function changePrice(uint _price) public onlyOwner {
      price = _price;
   }
}
```
