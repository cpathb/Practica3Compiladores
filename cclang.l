%{
    #include "definiciones.h"
%}

DIGITO              [0-9]
ENTERO              ({DIGITO}[_]?)+
CIENTIFICO          {ENTERO}[eE][+-]?{ENTERO}
DECIMAL             {ENTERO}"."{ENTERO}
DECIMALCIENTIFICO   {DECIMAL}[eE][+-]?{ENTERO}
IDENTIFICADOR       [_a-zA-Z][_a-zA-Z0-9]*
COMENTARIOLINEA     "//"[^\n]*
TOKENSIMPLE         [\+\-\*\/\=\(\)\;]

%%

{ENTERO} /* Enteros */ printf("Entero: %d\n",NUMEROENTERO);/* return(NUMEROENTERO); */
{CIENTIFICO} /* Científico */ printf("Científico: %d\n",NUMEROCIENTIFICO);/* return(NUMEROCIENTIFICO);*/
{DECIMAL} /* Decimal */ printf("Decimal: %d\n",NUMERODECIMAL);/* return(NUMERODECIMAL);*/
{DECIMALCIENTIFICO} /* Decimal Científico */ printf("Científico: %d\n",NUMEROCIENTIFICO);/* return(NUMEROCIENTIFICO);*/
sin /* Función seno */ printf("Seno: %d\n",FUNCION); /* return(FUNCION);*/
cos /* Función coseno */ printf("Coseno: %d\n",FUNCION); /* return(FUNCION);*/
tan /* Función tangente */ printf("Tangente: %d\n",FUNCION); /* return(FUNCION);*/
sinh /* Función arcoseno */ printf("Arcoseno: %d\n",FUNCION); /* return(FUNCION);*/
cosh /* Función arcocoseno */ printf("Arcocoseno: %d\n",FUNCION); /* return(FUNCION);*/
tanh /* Función arcotangente */ printf("Arcotangente: %d\n",FUNCION); /* return(FUNCION);*/
log /* Función logaritmo */ printf("Logaritmo: %d\n",FUNCION); /* return(FUNCION);*/
exp /* Función exponencial */ printf("Exponencial: %d\n",FUNCION); /* return(FUNCION);*/
{IDENTIFICADOR} /* Identificador */ printf("Variable: %d\n",VARIABLE); /* return(VARIABLE);*/
{TOKENSIMPLE} /*TOKEN Simple*/ printf("Operador: %d\n",(int) yytext[0]);/* return((int) yytext[0]); */ 
\n /* Salto de línea*/ printf("Salto de línea\n");
[ \t\r\b\f] /* Simbolos que no se tienen que contemplar */ printf("Caracter despreciable\n");
<<EOF>>

%%

main(){
    yylex();
}