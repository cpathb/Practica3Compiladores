# **Importante**
Este documento está generado empleando MarkDown, por lo que necesitarás de un 
intérprete para ver el resultado final. Si no tienes ningún interprete puedes 
utilizar el siguiente enlace para acceder a un interprete online:

> **[https://stackedit.io/](https://stackedit.io/) (22/11/2016)**

<br>
<br>
<br>
<br>
<br>
<br>

# **Práctica 3 - Compiladores e Intérpretes**

<br>
<br>
<br>
<br>
<br>

## _**Calculadora Multifunción**_

<br>
<br>
<br>
<br>
<br>

# Autor: Carlos Parada Alfaya - [@cpathb](https://github.com/cpathb)

<br>
<br>
<br>
<br>

### Introducción
Creación de una calculadora multifunción que permite la interacción en linea de comandos, asi como ejecutar ficheros con secuencias de expresiones de cálculo matemático.

Esta calculadora soportará:
- Los operadores matemáticos básicos (+,-,*,/,^).
- Funciones propias de una calculadora científica (sin(),cos(),tan(),ln(),exp(),…).
- Identificara "pi" como el numero π y "e" como la constante de Euler.
- Las operaciones y funciones deberán poder realizarse tanto sobre números enteros como reales.

Para la realización de esta calculadora multifunción se ha decidido que se realizará una etapa de análisis léxico empleando **[flex](https://github.com/westes/flex)** y una etapa de análisis sintáctico empleando **[bison](https://www.gnu.org/software/bison/)**. En la etapa de análisis sintáctico es necesario añadirle aquellas acciones semánticas que permitan realizar las operaciones descritas.

Por último, para almacenar las variables que introducimos por teclado o leemos desde el fichero y los valores que toman a lo largo del cálculo, emplearemos una especie de tabla de símbolos extraida de un ejemplo del manual de bison, aunque se le han añadido algunas pequeñas modificaciones.

<br>
<br>
<br>

### **Compilación de la práctica**

Para garantizar la correcta compilación de la práctica, se ruega que una vez descomprimida no se muevan los archivos de su carpeta.

#### **Compilación de la práctica empleando un script**
> bash compilar.sh

<br>
<br>
<br>

#### **Compilación de la práctica en terminal**

##### **Compilación del fichero de la gramática con bison** 
> bison -d ccASint.y

<br>
<br>
<br>

##### **Compilación del analizador léxico con flex** 
> flex ccALex.l

<br>
<br>
<br>



##### **Compilación de los ficheros de fuente del programa**
> gcc main.c ccASint.tab.c estructura.c gestionErrores.c -lm -lfl -o practica3.out

<br>
<br>
<br>

### **Comando de ejecución de la práctica en terminal**

> ./practica3.out

<br>
<br>
<br>

### **Notas**
- Los archivos no deberán de moverse de la carpeta en la que estarán situados una vez se ha descomprimido el fichero .zip proporcionado en la entrega de la práctica, ya que si no, no se puede garantizar el correcto funcionamiento de la práctica.
- Deben de emplearse los comandos de compilación proporcionados en este documento o emplear el script de compilación para asegurar la correcta compilación de la práctica.
