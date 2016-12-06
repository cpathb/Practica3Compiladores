%{
    #include "estructura.h"
    #include "ccASint.tab.h"
    #include "gestionErrores.h"
    
    // Función para imprimir la ayuda
    void ayuda(){
        printf("*******************************AYUDA:*********************************\n");
        printf("Existen dos maneras de dar órdenes a la calculadora:\n   - Con punto y coma (muestra el resultado) -> a=2+3;\n   - Sin punto y coma (no muestra el resultado) -> a=2+3\n\nPara ejecutar una función soportada se usará por ejemplo:\n   sin(a)\n");
        printf("******************************COMANDOS********************************\n");
        printf("help\nHELP\n\t/*Función que muestra la ayuda por pantalla.*/\nload ruta\nLOAD ruta\n\t/*Función que carga un fichero y lo ejecuta en el programa.*/\nvars\nVARS\n\t/*Función que muestra las variables de la tabla de símbolos./*\nfuncs\nFUNCS\n\t/*Función que muestra las funciones de la tabla de símbolos.*/\nreset\nRESET\n\t/*Función que borra las variables de la calculadora.*/\nexit\nEXIT\n\t/*Función que ciera el programa.*/\n");
        printf("*****************************OPERADORES*******************************\n");
        printf("+\n\t/*Operador Suma*/ -> a + a\n-\n\t/*Operador Resta*/ -> a - a\n*\n\t/*Operador Producto*/ -> a * a\n/\n\t/*Operador División*/ -> a * a\n^\n\t/*Operador Exponenciación*/ -> a ^ a\n=\n\t/*Operador Asignación*/  -> a = a\n");
        printf("**********************************************************************\n\n");
    }

    symrec *s;
    
%}

%option noyywrap

DIGITO              [0-9]
ENTERO              ({DIGITO}[_]?)+
CIENTIFICO          {ENTERO}[eE][+-]?{ENTERO}
DECIMAL             {ENTERO}"."{ENTERO}
DECIMALCIENTIFICO   {DECIMAL}[eE][+-]?{ENTERO}
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*
TOKENSIMPLE         [\+\-\*\/\=\(\)\;\^]
NOMBREFICHERO       [a-zA-Z0-9]([a-zA-Z0-9])*
EXTENSION           ([a-zA-Z])*
RUTA                {NOMBREFICHERO}"."?{EXTENSION}
CARGA               "load "|"LOAD "
AYUDA               "HELP"|"help"
SALIR               "exit"|"EXIT"
VARIABLE            "vars"|"VARS"
FUNCION             "funcs"|"FUNCS"
REINICIAR           "reset"|"RESET"

%%

{AYUDA} /* Comando de ayuda */ {
    ayuda();
    BEGIN(INITIAL);
}

{CARGA}{RUTA} /* Comando de carga de fichero */ {
    FILE* fp = fopen(yytext+5, "r+"); /* Leemos el fichero */
    if(!fp){ /* Comprobamos la incorrecta apertura del fichero */
        imprimirError(1, yytext+5);
        yyin=stdin; /* Ponemos como entrada por defecto la entrada del sistema */
    }
    else{
        yyin = fp; /* Ponemos como entrada por defecto el fichero proporcionado */
    }
    BEGIN(INITIAL);
}

{REINICIAR} /* Función para mostrar las variables de la tabla de símbolo */ {
    reiniciarTablaSimbolos();
    BEGIN(INITIAL);
}

{SALIR} /* Función para salir del programa */ {
    printf("Hasta pronto amigo!!\n");
    BEGIN(INITIAL);
    return EXIT;
}

{FUNCION} /* Función para mostrar las variables de la tabla de símbolo */ {
    imprimirFunciones();
    BEGIN(INITIAL);
}

{VARIABLE} /* Función para mostrar las variables de la tabla de símbolo */ {
    imprimirVariables();
    BEGIN(INITIAL);
}

{ENTERO} /* Enteros */ {
    yylval.NUM = atof(yytext);
    return NUM;

}

{CIENTIFICO} /* Científico */ {
    yylval.NUM = atof(yytext);
    return NUM;
}

{DECIMAL} /* Decimal */ {
    yylval.NUM = atof(yytext);
    return NUM;
}

{DECIMALCIENTIFICO} /* Decimal Científico */ {
    yylval.NUM = atof(yytext);
    return NUM;
}

{IDENTIFICADOR} /* Identificador */ {
    s = getsym(yytext); /* Intentamos obtener de la tabla de símbolos la variable/funcion/consrtante */
    if(s == 0){ /* Si no está en la tabla es una variable */
        s = putsym(yytext, VAR, 'n'); /* Introducimos la variable en la tabla de símbolos*/
    }
    if(s->type==VAR){ /* Constante o variable */
        yylval.VAR = s; /* Introducimos el valor*/
    }
    else{ /* Función */
        yylval.FNCT = s; /* Introducimos el valor*/
    }
    return s->type;
}

{TOKENSIMPLE} /*TOKEN Simple*/ return yytext[0] ;

\n /* Salto de linea */ return '\n';
<<EOF>> {
    fclose(yyin);
    yyin=stdin;
    yyrestart(yyin);
    BEGIN(INITIAL);
    return '\n'; /* Necesario para que funcione la lectura de lectura de archivo, sino si no acaba el archivo con un salto de línea "Kaboom" */
}
[ \t\r\b\f] /* Simbolos que no se tienen que contemplar */
%%