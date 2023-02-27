# Sentencia if

```solidity
if (condicion)
{
    ...
}
else
{
    
}
```

# bucle for

```solidity
// (inizializador_contador; comprobar contador; argumentos)
for (i=0 ; i==5; i++)
{
    ...
}

// ejemplo
//Esto es un array dinamico de direcciones
    address [] direcciones;
    
    //añade una direccion al array
    function asociar() public{
        direcciones.push(msg.sender);
    }
    
    //Comprobar si la direccion esta en el array de direcciones
    function comprobarAsociacion() public view returns(bool, address){
        
        for(uint i=0; i< direcciones.length; i++){
            if(msg.sender==direcciones[i]){
                return (true, direcciones[i]);
            }
        }
    }
```

# Bucle while

```solidity
while (condicion)
{
    ...
}
```

## break

Detiene la ejecucion del bucle

```solidity
<bucle> ... 
{
    ...
    break;
    ....
}
```




