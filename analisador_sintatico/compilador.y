%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "list.h"

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
}

/* Declaração dos tokens... */

%token<ival> T_INT
%token<fval> T_REAL
%token T_VAR T_TINTEIRO T_TREAL T_TBOOLEANO 
%token T_TRUE T_FALSE
%token T_LEFT T_RIGHT T_CE T_CD			
%token T_OR T_AND T_NOT		
%token T_EQUAL T_DIF T_MENORE T_MAIORE T_MAIOR T_MENOR	
%token T_ATRIB T_PV T_NEWLINE T_QUIT								
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_MOD T_PLUS_PLUS  			
%token T_VOID							
%token T_IF T_ELSE T_WHILE T_FOR 
%token T_SCAN T_PRINT T_RETURN

%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

//%type<fval> exprREAL
//%type<ival> exprINT 

%start comp

%%

comp: line
	;

line: %empty
	| T_QUIT T_NEWLINE						{ printf("Até mais...\n"); exit(0); }
	| declaracao inicio
	| atribuicao inicio
	| cond inicio
	| entrada inicio
	;

declaracao:  T_TINTEIRO T_VAR  { printf("VARIAVEL INTEIRO LIDA\n"); }
	| T_TREAL T_VAR  { printf("VARIAVEL REAL LIDA\n"); }
	| T_TBOOLEANO T_VAR { printf("VARIAVEL BOOLEANA LIDA\n"); }
	;

inicio: T_NEWLINE line
	;

atribuicao: T_TINTEIRO T_VAR T_ATRIB exprINT { printf("ATRIBUIÇÃO LIDA (INT)\n"); }
	| T_TREAL T_VAR T_ATRIB exprREAL { printf("ATRIBUIÇÃO LIDA (REAL)\n"); }
	| T_TBOOLEANO T_VAR T_ATRIB T_TRUE	{  printf("ATRIBUIÇÃO LIDA (BOOL)\n"); }
	| T_TBOOLEANO T_VAR T_ATRIB T_FALSE	 {  printf("ATRIBUIÇÃO LIDA (BOOL)\n"); }
	;

exprINT: T_INT
	| exprINT T_PLUS exprINT
	| exprINT T_MINUS exprINT
	| exprINT T_MULTIPLY exprINT
	| exprINT T_DIVIDE exprINT	
	| T_LEFT exprINT T_RIGHT
	| T_VAR T_PLUS exprINT
	| T_VAR T_MINUS exprINT
	| T_VAR T_MULTIPLY exprINT
	;

exprREAL: T_REAL
	| exprREAL T_PLUS exprREAL
	| exprREAL T_MINUS exprREAL
	| exprREAL T_MULTIPLY exprREAL
	| exprREAL T_DIVIDE exprREAL	
	| T_LEFT exprREAL T_RIGHT
	| exprINT T_PLUS exprREAL
	| exprINT T_MINUS exprREAL
	| exprINT T_MULTIPLY exprREAL
	| exprINT T_DIVIDE exprREAL	
	| exprREAL T_PLUS exprINT
	| exprREAL T_MINUS exprINT
	| exprREAL T_MULTIPLY exprINT
	| exprREAL T_DIVIDE exprINT
	;

relacional: T_VAR T_MAIOR exprINT { printf("OPERAÇÃO RELACIONAL LIDA (VAR > exprINT)\n"); }
	| T_VAR T_MENOR exprINT { printf("OPERAÇÃO RELACIONAL LIDA (VAR < exprINT)\n"); }
	| T_VAR T_MAIORE exprINT { printf("OPERAÇÃO RELACIONAL LIDA (VAR >= exprINT)\n"); }
	| T_VAR T_MENORE exprINT { printf("OPERAÇÃO RELACIONAL LIDA (VAR <= exprINT)\n"); }
	| T_VAR T_EQUAL exprINT { printf("OPERAÇÃO RELACIONAL LIDA (VAR == exprINT)\n"); }
	| T_VAR T_DIF exprINT { printf("OPERAÇÃO RELACIONAL LIDA (VAR != exprINT)\n"); }

	|T_VAR T_MAIOR exprREAL { printf("OPERAÇÃO RELACIONAL LIDA (VAR > exprREAL)\n"); }
	| T_VAR T_MENOR exprREAL { printf("OPERAÇÃO RELACIONAL LIDA (VAR < exprREAL)\n"); }
	| T_VAR T_MAIORE exprREAL { printf("OPERAÇÃO RELACIONAL LIDA (VAR >= exprREAL)\n"); }
	| T_VAR T_MENORE exprREAL { printf("OPERAÇÃO RELACIONAL LIDA (VAR <= exprREAL)\n"); }
	| T_VAR T_EQUAL exprREAL { printf("OPERAÇÃO RELACIONAL LIDA (VAR == exprREAL)\n"); }
	| T_VAR T_DIF exprREAL{ printf("OPERAÇÃO RELACIONAL LIDA (VAR != exprREAL)\n"); }
	
	|T_VAR T_MAIOR T_VAR { printf("OPERAÇÃO RELACIONAL LIDA (VAR > VAR)\n"); }
	| T_VAR T_MENOR  T_VAR { printf("OPERAÇÃO RELACIONAL LIDA (VAR < VAR)\n"); }
	| T_VAR T_MAIORE T_VAR { printf("OPERAÇÃO RELACIONAL LIDA (VAR >= VAR)\n"); }
	| T_VAR T_MENORE T_VAR { printf("OPERAÇÃO RELACIONAL LIDA (VAR <= VAR)\n"); }
	| T_VAR T_EQUAL T_VAR { printf("OPERAÇÃO RELACIONAL LIDA (VAR == VAR)\n"); }
	| T_VAR T_DIF T_VAR { printf("OPERAÇÃO RELACIONAL LIDA (VAR != VAR)\n"); }
	;

oplogica:  %empty
	| T_AND relacional oplogica 
	| T_OR relacional oplogica
	;

bloco: %empty 
	| T_CE inicio T_NEWLINE return T_CD
	;

return: %empty	
	| T_RETURN T_VAR	
	;

entrada: T_SCAN T_LEFT T_VAR T_RIGHT
	;

cond: T_IF relacional oplogica bloco {printf("Operacao condicional LIDA (IF)\n");}
	| T_IF relacional oplogica bloco T_ELSE bloco
	| T_WHILE T_LEFT relacional oplogica T_RIGHT bloco
	;

%%


int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	exit(1);
}

