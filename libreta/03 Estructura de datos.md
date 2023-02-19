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




