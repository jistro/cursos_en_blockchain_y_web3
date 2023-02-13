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

![02_img1.png](/home/jistro/GitHub/curso_solidity/libreta/img/02_img1.png)

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

 


