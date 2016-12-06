typedef double (*func_t) (double); // Tipo Función

struct symrec { // Tipo de datos que se emplearán en la estructura
    char *name; // Nombre
    int type; // Tipo: VAR o FNCT
    union {
        double var; // Campo para almacenar el valor de una Variable (solo en VAR) 
        func_t fnctptr; // Campo para almacenar el puntero a una función (Solo en FNCT)
    } value;
    char constant; // Campo para definir si es constante 'y' o se puede modificar 'n'
    struct symrec *next; // Campo que enlaza con el siguiente dato de la estructura
};

typedef struct symrec symrec;

extern symrec *sym_table;

// Declaración de funciones
void inicializarTablaSimbolos();
void destruirTablaSimbolos();
void liberarNodoTablaSimbolos(symrec **nodo);
void reiniciarTablaSimbolos();
void imprimirVariables();
void imprimirFunciones();
symrec * putsym (char const *sym_name, int sym_type, char sym_const);
symrec *getsym (char const *);