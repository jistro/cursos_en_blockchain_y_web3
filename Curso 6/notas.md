# Leccion 6

## Uso de Foundry

Es una frame de desarrollo de smart contract, que esta escrito en rust y permite desde el desarrollo hasta el despliegue usando solamente solidity.

## Cosas a tener en cuenta

- Foundry contiene su propia blockchain de pruebas llamado **anvil**

- Para compilar un contrato en foundry se usa el comando `forge compile` y para desplegarlo `forge create <nombre del contrato>` ademas de eso debemos agregar ciertas flags para subirlo como 
  
  - `-r` o `--rpc-url` como dice el nombre es la url del rpc de la blockchain que queremos usar
  - `-c` o `--chain` es el id de la blockchain que queremos usar
  - `-i` o `--interactive` para ingresar la llave privada de la cuenta que queremos usar

# ejecutar scripts

recordemos que foundry usa totalmente solidity por lo tanto podemos usar los scripts debemoos alamcenarlo en la carpeta de `script` y guardarlo con `.s.sol` 

```solidity
// SPDX-License-Identifier: MIT
pragma solidity >=0.8.18;

import "forge-std/Script.sol";
import {SimpleStorage} from "../src/SimpleStorage.sol";
contract DeploySimpleStorage is Script{
    function run() external returns (SimpleStorage){
        // ejecutara y mostrara cuando usemos el comando forge script
        vm.startBroadcast();
        SimpleStorage simpleStorage = new SimpleStorage();
        vm.stopBroadcast();
        return simpleStorage;
    }
}
```

al ejecutar el script foundry ejecutara anvil para el script y nos mostrara el resultado

si bien `vm.startBroadcast();` es un Cheatcode que permite iniciar el broadcast de la transaccion y `vm.stopBroadcast();` lo dediene 

para ejecutar usamos `forge script script/<nombre del script>.s.sol` y para subirlo a una blockchain usamos `forge script script/<nombre del script>.s.sol -r <url del rpc> -c <id de la blockchain> -i`
o podemos cambiar `-i` por `--private-key` y agregar la llave privada de la cuenta que queremos usar

podemos usar cast para comvertir datos 

`cast --to-base <hex> dec `

podemos en en vez de agregar el texto de la llave privada podemos usar un `.env`
primero declaramos el env con lo siguiente 

```env
PRIVATE_KEY=<llave privada>
RPC_URL=<url del rpc>
```

después usamos `source .env`

y llamamos la funcion asi 

`forge script script/<nombre del script>.s.sol --rpc-url $RPC_URL -c <id de la blockchain> --private-key $PRIVATE_KEY`

**Nota:** **JAMAS SUBIR EL ENV A UN REPOSITORIO PUBLICO, USA SIEMPRE EL GITIGNORE PARA IGNORARLO Y SE QUEDE EN TU PC**
**NUNCA JAMAS DE LOS JAMASES DEBES PUBLICAR EL ENV**

Podemos usar `-i` o `--interactive` para que cuando ingresemos la llave privada no se muestre en la consola o usemos el env

---

`npx thirdweb deploy`
para deployar contratos en thirdweb 

---

para interactuar desde la consola en alguna función usamos 
`cast send <Direccion del contrato> "nombre_funcion(tipo_variable nombre_variable)" <datos de variable> --rpc-url $RPC_URL --private-key $PRIVATE_KEY`

para hacer call hacemos 

`cast call <direccion contrato> "nombre_funcion()"`

esto saldrá en hex por lo tanto debemos usar `cast --to-base <hex> dec` para convertirlo a decimal o podemos 

```
  --to-ascii               Convert hex data to an ASCII string [aliases: to-ascii, tas, 2as]
  --to-base                Converts a number of one base to another [aliases: to-base,
                               --to-radix, to-radix, tr, 2r]
  --to-bytes32             Right-pads hex data to 32 bytes [aliases: to-bytes32, tb, 2b]
  --to-checksum-address    Convert an address to a checksummed format (EIP-55) [aliases:
                               to-checksum-address, --to-checksum, to-checksum, ta, 2a]
  --to-dec                 Converts a number of one base to decimal [aliases: to-dec, td,
                               2d]
  --to-fix                 Convert an integer into a fixed point number [aliases: to-fix,
                               tf, 2f]
  --to-hex                 Converts a number of one base to another [aliases: to-hex, th,
                               2h]
  --to-hexdata             Normalize the input to lowercase, 0x-prefixed hex [aliases:
                               to-hexdata, thd, 2hd]
  --to-int256              Convert a number to a hex-encoded int256 [aliases: to-int256, ti,
                               2i]
  --to-rlp                 RLP encodes hex data, or an array of hex data
  --to-uint256             Convert a number to a hex-encoded uint256 [aliases: to-uint256,
                               tu, 2u]
  --to-unit                Convert an ETH amount into another unit (ether, gwei or wei)
                               [aliases: to-unit, tun, 2un]
  --to-wei                 Convert an ETH amount to wei [aliases: to-wei, tw, 2w]
```

-------

# Leccion 7

## agregar librerias

en foundry podemos instalar las librerias que usemos con

```bash
forge install <direccion de libreria en github>[@version] 
```

en la direccion para gitgub no debemos agregar el `github.com/` y la version es opcional ademas podemos agregar `--no-commit` para que git nop haga commit

con esto agregaremos en automatico a la carpeta `lib` los contratos/librerias que usaremos

## test

`forge test` nos ayudara a testear nuestro contrato inteligente 

tomaremos el ejemplo del codigo que viene por defecto cuando usamos `forge init`

```solidity
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
```

en este caso hacemos fila de las funciones es decir primero setup despues test increment y consecutivo

test increment lo que hace es verificar si depues de llamar a la funcion add es 1

**Test siempre llamara antes que nada a la funcion `setUp()`** 

si `import {Test} from "forge-std/Test.sol";` ayuda a solo testear tambien podemos hacer algo parecido a `console.log()` de js, usando `import {Test, console} from "forge-std/Test.sol";` podemos mostrar variables en consola usando

```solidity
console.log(<variable>)
```

y para ver los logs usamos el comando 

```bash
forge test -vv
```
