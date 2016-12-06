// Archivo para inicializar la tabla de símbolos
struct init_functions{ // Tipo de datos que se emplearán en la estructura para las funciones 
    char const *function_name;
    double (*fnct) (double);
};

struct init_constants{ // Tipo de datos que se emplearán en la estructura para las constantes
    char const *constant_name;
    double value;
};

// Estrutura para cargar las funciones al inicio del programa
struct init_functions const arith_functions[] ={
    { "sin",  sin   },
    { "cos",  cos   },
    { "tan",  tan   },
    { "asin", asin  },
    { "acos", acos  },
    { "atan", atan  },
    { "exp",  exp   },
    { "ln",   log   },
    { "sqrt", sqrt  },
    { 0,      0     },
};

// Estrutura para cargar las constantes al inicio del programa
struct init_constants const math_constants[] ={
    { "pi", M_PI    },
    { "e" ,  M_E    },
    { 0   ,    0    },
};