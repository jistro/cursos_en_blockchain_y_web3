Durante el desarrollo de un proyecto tal vez en algún momento nos interese la creación de un contrato que pueda desarrollar otros contratos inteligentes y cada uno de ellos puede tener funcionalidades distintas, esto se le conoce como factory o fabrica

La implementacion es el siguiente 

```solidity
contract contratoFabrica
{
    function factory() public
    {
        address direccionDeNUevoContrato = address (new nombreContrato(parametros) )
    }
}

contract nombreContrato
{
    constructor(parametros) public {...}
}
```

 Lo que hacemos es generar un contrato fabrica que pueda generar este nuevo contrato desde una dirección diferente



En el contrato que se va a generar debemos especificar la información en el constructor como los parámetros que tendrá el nuevo contrato


