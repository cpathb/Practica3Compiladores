%{
    #include "estructura.h"
    #include "ccASint.tab.h"
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

{ENTERO} /* Enteros */ return(NUM);
{CIENTIFICO} /* Científico */ /* return(NUM); */
{DECIMAL} /* Decimal */ return(NUM);
{DECIMALCIENTIFICO} /* Decimal Científico */ /* return(NUMEROCIENTIFICO);*/
sin /* Función seno */  return(FNCT);
cos /* Función coseno */ return(FNCT);
tan /* Función tangente */ return(FNCT);
sinh /* Función arcoseno */ return(FNCT);
cosh /* Función arcocoseno */ return(FNCT);
tanh /* Función arcotangente */ return(FNCT);
log /* Función logaritmo */ return(FNCT);
exp /* Función exponencial */ return(FNCT);
{IDENTIFICADOR} /* Identificador */ return(VAR);
{TOKENSIMPLE} /*TOKEN Simple*/ return((int) yytext[0]);
\n /* Salto de línea*/ 
<<EOF>>
[ .\t\r\b\f] /* Simbolos que no se tienen que contemplar */

%%