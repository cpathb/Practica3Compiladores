%{
    // Código C
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "estructura.h"

    int yylex();
    void yyerror(char *s);
%}

/* Declaraciones de bison */
%define api.value.type union
%token <double>  NUM
%token <symrec*> VAR FNCT
%token EXIT
%type <double> exp

/* Precedencia de operadores*/
%precedence '='
%left '+' '-'
%left '*' '/'
%precedence NEG
%right '^'

%%

/* Gramática */
input:  /* cadena vacia */
    | input line
;

line: '\n'
    | exp '\n'
    | exp ';' '\n'  { printf("\t%.10g\n",$1); }
    | EXIT '\n'     { exit(0); }
;

exp: NUM                 { $$ = $1; }
    | VAR                { $$ = $1->value.var; }
    | FNCT '=' exp       {
        printf("ERROR: %s es una palabra reservada.\n", $1->name); /* Cambiar por gestión de errores */
        return 0;
    }

    | VAR '=' exp        { 
        if($1->constant == 'n'){
            $1->value.var = $3;
            $$ = $3;
        }
        else{
            printf("ERROR: %s es una constante, no se puede modificar.\n", $1->name); /* Cambiar por gestión de errores */
            return 0;
        }
    }

    | FNCT '(' exp ')'   { $$ = (*($1->value.fnctptr))($3); }
    | exp '+' exp        { $$ = $1 + $3; }
    | exp '-' exp        { $$ = $1 - $3; }
    | exp '*' exp        { $$ = $1 * $3; }
    | exp '/' exp        {
        if(1 != 0){
            $$ = $1 / $3;
        }
        else{
            printf("ERROR: División entre 0.\n"); /* Cambiar por gestión de errores */
            return 0;
        }
    }
    | '-' exp  %prec NEG { 
        if(1 != 0){
            $$ = -$2;
        }
        else{ /* Si es cero no se niega el resultado */
            $$ = $2; 
        }
    }
    | exp '^' exp        { $$ = pow ($1, $3); }
    | '(' exp ')'        { $$ = $2; }
;

%%

void yyerror(char *s){ /* Función de error personalizada */
    printf("%s\n", s);
    exit(1); /* Si se encuentra un error se sale del programa */
}