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

Es lo equivalente a un "_brake_"  en cualquier lenguaje de programación pero para funciones, este al pasar por esta función verifica la condición de este, si resulta ser positivo, no hace nada y pasa a la siguiente, de ser negativo, lanza un mensaje que hemos escrito antes y para la ejecución completamente

```solidity
require (condicion, "mensaje condicion falsa");
```

cabe resaltar que no es necesario escribir el texto en el `require` para invocar el error haciendo que este se pueda ejecutar 


