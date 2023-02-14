# Tipos de variables y operadores

como javascript la declaración de variables en solidity se conforma de la siguiente manera

```solidity
//declaracion de variables
<tipo de dato> <nombre de variable>;
//inizializacion de variable 
<tipo de dato> <nombre variable> = <valor>;
```

## Tipos de variable

### Variables enteras

Existen dos tipos de enteros, con signo `int` y sin signo `uint`

Las mas usadas en contratos inteligentes son las sin signo, la diferencia con `int` y `unit` es que `int` abarca tanto los positivos como los negativos, y `uint` abarca solo los positivos

<img src="./img/02_img1.png" title="" alt="02_img1.png" data-align="center">

también a estas podemos especificar los bits de la variable, es decir esto lo podemos hacer de la siguiente manera 

```solidity
int<X> <variable>;

uint<X> <variable>;
```

Siendo _X_ el numero de bits, este puede variar de 8 a 256 **en múltiplos de 8**, por defecto solidity asigna 256 bits si no se especifica

### Variables string

Las strings que se crean son del tipo UTF-8

```solidity
string <nombre variable>;
string <nombre variable> = "texto";
```

hay ciertos caracteres especiales en solidity cuando se trata de strings y estos son

| carácter | función                                           |
|:--------:| ------------------------------------------------- |
| \n       | Inicia nueva linea                                |
| \\\      | Agrega \ al texto                                 |
| \'       | Agrega camilla simple al texto                    |
| \"       | Agrega camilla al texto                           |
| \b       | Agrega "Backspace"                                |
| \f       | Agrega salto de pagina                            |
| \r       | Agrega salto de linea                             |
| \t       | Agrega tabulación                                 |
| \v       | Agrega tabulación vertical                        |
| \xNN     | Representa el valor de un carácter en Hexagesimal |
| \uNNN    | Representa el valor de un carácter en UTF-8       |

### Variables booleanas

Estas son semejantes a javascript, se declaran de la siguiente manera

```solidity
bool <nombre_var> = true;
bool <nombre_var> = false;
```

### Variables bytes o byte

Estas almacenan bytes o bytes, se declaran de la siguiente manera

```solidity
//siendo x la cantidad de bytes almacenados
bytes<X> <nombre_var>;
bite <nombre_var>; //para almacenar un solo byte
```

`bytes` permite almacenar de 1 a 32 bytes en un intervalo de 1 unidad

`byte` solo permite almacenar un único byte

### Variable address

Permite almacenar la dirección de la cuenta 

```solidity
address <nombre_var>;
```

### Variables enums

Son una manera de que el usuario pueda crear su propio tipo de datos

```solidity
enum nombre_enumeracion 
{
    valores_enumeracion1, ... ,valor enumeracionN
}
```

Como declarar una variable tipo `enum`

```solidity
//como invocarlo
nombre_enumeracion ;
```

Existen dos maneras de modificar este tipo de variables

Especificando la opción de `enum`

```solidity
<nombre_variable> = <nombre_enumeracion>.<valor_enumeracion>
```

Usando el indice

```solidity
<nombre_variable> = <nombre_enumeracion>( <posicion> );
```

Ejemplo:

```solidity
enum estado {ON,OFF}   
/* recordar que 
    ON  es el indice 0
    OFF es el indice 1
*/
    estado interruptor;

    function encender() public
    {
        interruptor = estado.ON;
    }
    
    function accion(uint _k) public 
    {
        interruptor = estado(_k);
    }
    
    function devolverDatos() public view returns(estado)
    {
        return interruptor;
    }
```
