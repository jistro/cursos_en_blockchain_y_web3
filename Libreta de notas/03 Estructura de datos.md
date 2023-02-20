# Estructuras

Las `struct` son necesarias cuando manejamos tipos de datos mas complejos 

```solidity
struct nombre_estructura
{
    tipo_variable_1 nombre_variable_1;
    tipo_variable_2 nombre_variable_2;
    tipo_variable_3 nombre_variable_3;
    ...
    tipo_variable_n nombre_variable_n;
}
```

para declarar y/o inicializar una estructura se debe declarar poniendo el nombre de la estructura seguido de la variable para esa nueva estructura junto con sus datos de iniciación 

```solidity
// Declarar solo la variable
nombre_estructura nombre_variable;

// Declarar la variable con la inizializacion
nombre_estructura nombre_variable = nombre_estructura (propiedades)
```

por ejemplo, una estructura para un sistema registrar una persona

```solidity
struct persona
{
    string nombres;
    string apellidos;
    uint8  diaNacimiento;
    uint8  mesNacimiento;
    uint   annoNacimeinto,
}

persona usuario = persona (jose, ruiz, 5, 7, 1970);
```

# mapping

es un sistema de estructura de datos que permite guardar o ver datos que están asociadas a una clave-valor, podemos ver esto como la llave principal en un SQL, podemos marcar opcionalmente los mappings como `public` para crear un getter del código

```solidity
mapping (_keytype => _valueType) public nombre_mapping;
```

Guardar datos;

```solidity
nombre_mapping [_key] = _value;
```

   Ver datos

```solidity
nombre_mapping [_key];
```

# Array

Como cualquier lenguaje de programación, un array es un tipo de dato estructurado que almacena un conjunto homogéneo de datos. Hay dos tipos de arrays, de longitud fija y dinámicos.

## Array de longitud fija

En este tipo de array esta definido la longitud de esta

```solidity
<tipo_de_dato> [<longitud>] [public]* <nombreArray>;
```

Por ejemplo, pensemos en un array publica que muestre la lista de una clase

```solidity
string [22] public listaAumnos;
```

## Array dinámico

Este tipo de arrays no tienen definido su longitud

```solidity
<tipo_de_dato> [] [public]* <nombreArray>;
```

Por ejemplo pensemos en una lista de direcciones que pasan por nuestro contrato

```solidity
address [] public listaAddress;
```

## Inicializar de un array

Si bien no es muy recomendable hacer eso en un contrato real, solidity nos permite esto, usemos nuestros ejemplos anteriores

```solidity
//longitud fija
string [22] public listaAumnos = [jose,luis,maria,...,pedro];
//longitud dinamica
address [] public listaAddress = [0x808Fd5c4cF64F7f6b0042630335D7543d5782c1a,
                                  ...,
                                  0xC3b8E8c851A51f5e6115f851121655b2689Cc3b2]
```

## Lectura y escritura con array

Solidity como cualquier otro lenguaje nos permite leer/escribir en arrays

```solidity
//lectura
<nombre_array>[<posicion>];
//escritura
<nombre_array>[<posicion>] = <valor>;
```

## Función .push() y length

Hay dos funciones que permiten agregar un elemento al final y ver la longitud del array, los cuales son `.push()` y `.length` respectivamente.

```solidity
// funcion push
nombreArray.push(valor);
// funcion length
nombreArray.length;
```

Por obvios motivos, `.push()` solo sirve para arrays dinámicos, ya que estos no tienen definido su longitud por lo tanto esta función nos ayuda a colocarlo al ultimo.




