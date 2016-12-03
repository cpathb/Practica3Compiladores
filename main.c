#include <stdlib.h>
#include <stdio.h>
#include "lex.yy.c"
#include "ccASint.tab.h"

int main( int argc, const char* argv[] ){
    inicializarTablaSimbolos(); // inicializamos la "tabla de simbolos"
    yyin = stdin; // Definimos la entrada de flex como la entrada del sistema
    printf("Iniciando \"Complex Calculator\"...\n\tPuede obtener ayuda usando el comando \"help\"o \"HELP\"\n");
    while(!feof(yyin)){
        yyparse(); // Lanzamos la ejecución del analizador sintáctico
    }
}