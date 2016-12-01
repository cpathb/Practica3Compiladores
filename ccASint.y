%{
    /* Código C*/
    #include <math.h>
    #include <stdio.h>
    #include "estructura.h"

    int yylex();
    void yyerror(char *s);
    void init_table();

%}

/* Declaraciones de bison */
%define api.value.type union
%token <double>  NUM
%token <symrec*> VAR FNCT
%type <double> exp

/* Precedencia de operadores*/
%precedence '='
%left '+' '-'
%left '*' '/'
%precedence NEG

%%
/* Gramática */

input:  /* cadena vacia */
    | input line
;

line:   '\n'
    | exp '\n'
    | exp ';' '\n'  { printf("\t%.10g\n",$1); }
    | error '\n' { yyerrok; }
;

exp: NUM                 { $$ = $1; }
    | VAR                { $$ = $1->value.var; }
    | VAR '=' exp        { $$ = $3; $1->value.var = $3; }
    | FNCT '(' exp ')'   { $$ = (*($1->value.fnctptr))($3); }
    | exp '+' exp        { $$ = $1 + $3; }
    | exp '-' exp        { $$ = $1 - $3; }
    | exp '*' exp        { $$ = $1 * $3; }
    | exp '/' exp        { $$ = $1 / $3; }
    | '-' exp  %prec NEG { $$ = -$2; }
    | '(' exp ')'        { $$ = $2; }
;

%%
#include <ctype.h>

int main (){
    init_table();
    yyparse ();
}

int yylex(){
    int c;

    while ((c = getchar()) == ' ' || c == '\t');
    if (c == EOF){
        return 0;
    }

    if (c == '.' || isdigit(c)){
        ungetc(c, stdin);
        scanf("%lf", &yylval.NUM);
        return NUM;
    }

    if (isalpha(c)){
        symrec *s;
        static char *symbuf = 0;
        static int length = 0;
        int i;

        if (length == 0){
            length = 40, symbuf = (char *)malloc(length + 1);
        }

        i = 0;
        do{
            if (i == length){
                length *= 2;
                symbuf = (char *)realloc(symbuf, length + 1);
            }
            symbuf[i++] = c;
            c = getchar();
        } while (c != EOF && isalnum(c));
        
        ungetc(c, stdin);
        symbuf[i] = '\0';
        s = getsym(symbuf);
        if (s == 0){
            s = putsym(symbuf, VAR);
        }
        
        yylval.VAR = s;
        return s->type;
    }
    /* Cualquier otro caracter es un token por s mismo. */
    return c;
}

void yyerror(char *s){
    printf ("%s\n", s);
}

void init_table() {
  int i;
    for (i = 0; arith_fncts[i].fname != 0; i++) {
        symrec *ptr = putsym (arith_fncts[i].fname, FNCT);
        ptr->value.fnctptr = arith_fncts[i].fnct;
    }
}