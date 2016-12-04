#!/bin/bash
bison -d ccASint.y
flex ccALex.l
gcc main.c ccASint.tab.c estructura.c -lm -lfl -o practica3.out