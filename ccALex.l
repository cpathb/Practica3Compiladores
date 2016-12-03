%{
    #include "estructura.h"
    #include "ccASint.tab.h"
    
    // Función para imprimir la ayuda
    void ayuda(){
        printf("*******************************AYUDA:*********************************\n");
        printf("******************************COMANDOS********************************\n");
        printf("help\nHELP\n\t/*Función que muestra la ayuda por pantalla.*/\nload ruta\nLOAD ruta\n\t/*Función que carga un fichero y lo ejecuta en el programa.*/\nvars\nVARS\n\t/*Función que muestra las variables de la tabla de símbolos./*\nfuncs\nFUNCS\n\t/*Función que muestra las funciones de la tabla de símbolos.*/\nreset\nRESET\n\t/*Función que reinicia la tabla de símbolos a sus valores por defecto.*/\nexit\nEXIT\n\t/*Función que ciera el programa.*/\n");
        printf("*****************************OPERADORES*******************************\n");
        printf("+\n\t/*Operador Suma*/\n-\n\t/*Operador Resta*/\n*\n\t/*Operador Producto*/\n/\n\t/*Operador División*/\n^\n\t/*Operador Exponenciación*/\n=\n\t/*Operador Asignación*/\n");
        printf("**********************************************************************\n");
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
AYUDA               "HELP"|"help"
RUTA                [[:alpha:]/\-_]+[.?[[:alpha:]]+]?
CARGA               "load "|"LOAD "RUTA
SALIR               "exit"|"EXIT"
VARIABLE            "vars"|"VARS"
FUNCION             "funcs"|"FUNCS"
REINICIAR           "reset"|"RESET"
TOKENSIMPLE         [\+\-\*\/\=\(\)\;\^]
FUNCIONES           "sin"|"cos"|"tan"|"sinh"|"cosh"|"tanh"|"log"|"exp"

%%

{FUNCIONES} /* Funciónes aritméticas */ return FNCT;
{AYUDA} /* Comando de ayuda */ {
    ayuda();
    BEGIN(INITIAL);
}

{CARGA} /* Comando de carga de fichero */ {
    FILE* fp = fopen(yytext+5, "r+"); /* Leemos el fichero */
    if(!fp){ /* Comprobamos la incorrecta apertura del fichero */
        printf("Error cargando el fichero\n"); /* Cambiar por gestion errores */
        yyin=stdin; /* Ponemos como entrada por defecto la entrada del sistema */
    }
    else{
        yyin = fp; /* Ponemos como entrada por defecto el fichero proporcionado */
        printf("Fichero cargado: %s\n", yytext+5); /* Pasamos el fichero indicado */
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
     s = getsym(yytext); /* Intentamos obtener de la tabla de símbolos la variable */
    if(s == 0){ /* Si no está en la tabla... */
        s = putsym(yytext, VAR, 'n'); /* Introducimos la variable en la tabla de símbolos*/
    }
    yylval.VAR = s; /* Introducimos el valor*/
    return s->type;
}

{TOKENSIMPLE} /*TOKEN Simple*/ return yytext[0] ;

\n /* Salto de linea */ return '\n';
[\t\r\b\f] /* Simbolos que no se tienen que contemplar */
<<EOF>> {
    fclose(yyin);
    yyin=stdin;
    yyrestart(yyin);
    BEGIN(INITIAL);
    return '\n';
}
%%