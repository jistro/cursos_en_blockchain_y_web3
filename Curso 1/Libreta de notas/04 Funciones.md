# Funciones (estructura)

Sirven para ejecutar un bloque de código dentro de un contrato 

```solidity
// Estructura de una funcion
function <nombreDeFuncion> (<parametros>) [public || private]
{
    ...
}
```

Aunque no es un protocolo, muchos desarrolladores de smart contract usan barra baja en las variables de una función, si bien esto ayuda a identificar no es necesario implementar, junto con ello es una buena practica poner `private` a todas las funciones que no queramos que sean visibles al usuario

# Valores de retorno en funciones

A diferencia de otros lenguajes de programación donde `return` ya viene por defecto, en solidity tenemos que declarar que habrá un valor de retorno, este se hace mediante `retunrs` seguido del tipo de variable que se le regresara, veamos la estructura para estar mas claro de esto

```solidity
function <nombreDeFuncion> (<parametros>) [public/private] returns(<tipoVariables>)
{
    ...
    return <nombreVariables>;
}
```

La declaración `returns` no solo puede devolver un valor si no también podemos devolver varios en la misma función, solamente debemos separar con una coma.

Ejemplos

```solidity
contract Test 
{
   function getResult() public view returns(uint)
    {
         uint a = 1; // local variable
         uint b = 2;
         uint result = a + b;
         return result;
    }
}
```

```solidity
contract Test 
{
    function getResult() public view returns(uint product, uint sum)
    {
         uint a = 1; // local variable
         uint b = 2;
         product = a * b;
         sum = a + b;

         //alternative return statement to return 
         //multiple values
         //return(a*b, a+b);
     }
}
```

Nota en el caso de que solo queremos una variable de multiples debemos escribir asi

```solidity
contract Test 
{
    function getResult() public view returns(uint product, uint sum)
    {
         uint a = 1; // local variable
         uint b = 2;
         return(, a+b);
     }
}
```

# Modificadores view, pure y payable

Estos se pueden agregar junto con los modificadores de `public` y `private` ya que sus acciones son independientes de esta

```solidity
function nombreFuncion(parametros) [public|priavate] [modificadores] retunrs(variablesTipo)
{
    ...
}
```

Tenemos disponibles 3 tipos de modificadores

## view

Indicamos que no modificara los datos de variable dentro de la `function` pero si podemos acceder a ellos

## pure

Indicamos que no accederemos a los datos dentro de la `function` solamente va a depender de los valores que introducimos como parámetros, por tanto no es necesario acceder a loa datos ni siquiera accederemos a los datos

## payable

Como lo indica el nombre, permite realizar un pago recibiendo la criptomoneda nativa
