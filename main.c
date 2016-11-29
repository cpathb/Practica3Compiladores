//En este archivo.c se inicializarán las cosas
#include "analizadorLexico.h"
#include "tablaSimbolos.h"

int main( int argc, const char* argv[] ){
    inicializarTablasimbolos(); // Primero tabla de simbolos porque abre un archivo y lo cierra al acabar
    
    printf("\n\nContenido de la Tabla de Símbolos:\n");
    printf("----------------------------------\n");
    ImprimirTablaSimbolos(); // Imprimimos la tabla de símbolos en el orden creado por la función hash
    destruirTablasimbolos(); // Destruimos la tabla de símbolos
    destruirLex(); // Destruimos yylex
}
