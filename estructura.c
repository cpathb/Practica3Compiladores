#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include "estructura.h"
#include "ccASint.tab.h"

struct init_functions const arith_functions[] ={
    { "atan", atan  },
    { "cos",  cos   },
    { "exp",  exp   },
    { "ln",   log   },
    { "sin",  sin   },
    { "sqrt", sqrt  },
    { 0, 0          },
};


struct init_constants const math_constants[] ={
    { "pi", M_PI    },
    { "e",  M_E     },
    { 0,    0       },
};

symrec *sym_table;

// Función para inicalizar la tabla de símbolos, rellena tanto con las funciones como con las constantes
void inicializarTablaSimbolos(){
  int i;
    for (i = 0; arith_functions[i].function_name != 0; i++) {
        symrec *ptr = putsym(arith_functions[i].function_name, FNCT, 'n');
        ptr->value.fnctptr = arith_functions[i].fnct;
    }

    for (i = 0; math_constants[i].constant_name != 0; i++) {
        symrec *ptr = putsym(math_constants[i].constant_name, VAR, 'y');
        ptr->value.var = math_constants[i].value;
    }
}

// Función para eliminar la tabla de símbolos
void destruirTablaSimbolos(){
    printf("Destruir");
}

// Función para reiniciar la tabla de símbolos
void reiniciarTablaSimbolos(){
    printf("Reiniciar");
}

// Función para imprimir las variables de la tabla de símbolos
void imprimirVariables(){
    symrec *s=sym_table;
    printf("Variables utilizadas:\n");
    while(s->next != NULL){
        if(s->name != NULL && s->type == VAR){
            printf("\t %s = %g\n", s->name, s->value.var);
        }
        s=s->next;
    }
}

// Función para imprimir las funciones de la tabla de símbolos
void imprimirFunciones(){
    symrec *s=sym_table;
    printf("Funciones disponibles:\n");
    while(s->next != NULL){
        if(s->name != NULL && s->type == FNCT){
            printf("\t %s", s->name);
        }
        s=s->next;
    }
}

// Función para introducir una variable o constante en la tabla de símbolos
symrec * putsym (char const *sym_name, int sym_type, char sym_const) {
    symrec *ptr = (symrec *) malloc (sizeof (symrec));
    ptr->name = (char *) malloc (strlen (sym_name) + 1);
    strcpy (ptr->name,sym_name);
    ptr->type = sym_type;
    ptr->value.var = 0;
    ptr->constant = sym_const;
    ptr->next = (struct symrec *)sym_table;
    sym_table = ptr;
    return ptr;
}

// Función para obtener un valor en la tabla de símbolos
symrec * getsym (char const *sym_name) {
    symrec *ptr;
    for (ptr = sym_table; ptr != (symrec *) 0; ptr = (symrec *)ptr->next){
        if (strcmp (ptr->name, sym_name) == 0){
            return ptr;
        }
    }
    return 0;
}