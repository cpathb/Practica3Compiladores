#include <stdio.h>
#include <stdlib.h>
#include "gestionErrores.h"

void imprimirError(int codigo, char* cadena){
     switch (codigo){
        case 1:
            printf("Error al abrir el fichero %s que se empelará como entrada para la calculadora.\n", cadena);
            break;
        
        case 2:
            printf("ERROR: %s es una palabra reservada.\n",cadena);
            break;

        case 3:
            printf("ERROR: %s es una constante, no se puede modificar.\n",cadena);
            break;

        case 4:
            printf("ERROR: División entre 0.\n");
            break;

        case 5:
            printf("Error genérico: %s.\n",cadena);
            break;

         default:
            printf("Error no controlado.\n");
     }
}
