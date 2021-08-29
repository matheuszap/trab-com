%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "list.h"
#include "bytecode.h"

extern int yylex();
extern int yyparse();
extern FILE* yyin;
extern list *v;


void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
	char *sval;
}

/* Declaração dos tokens... */

%token<ival> T_INT
%token<fval> T_REAL
%token<sval> T_VAR T_TINTEIRO T_TREAL T_TBOOLEANO T_TRUE T_FALSE
%token T_LEFT T_RIGHT T_CE T_CD			
%token T_OR T_AND T_NOT		
%token T_EQUAL T_DIF T_MENORE T_MAIORE T_MAIOR T_MENOR	
%token T_ATRIB T_PV T_2P T_QUIT								
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_MOD T_PP T_MM  			
%token T_VOID							
%token T_IF T_ELSE T_DO T_WHILE T_FOR T_SWITCH T_CASE T_DEFAULT T_BREAK T_INRANGE
%token T_SCAN T_PRINT T_RETURN
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<fval> exprREAL
%type<ival> exprINT 


%start comp

%%

comp: {header();} start
	;

start: %empty
	| T_QUIT			{ final();list_delete(v); exit(0); }
	| declaracao start
	| atribuicao start
	| entrada start
	| saida start
	| while start
	| switch start
	| for start
	| plus start
	| minus start
	| cond start
	;

declaracao:  T_TINTEIRO T_VAR   				{ setTipo(v,$1,$2);printf("%s",$2);} 
	| T_TREAL T_VAR  							{ setTipo(v,$1,$2);}
	| T_TBOOLEANO T_VAR 						{ setTipo(v,$1,$2);}
	;


atribuicao: T_TINTEIRO T_VAR T_ATRIB exprINT 	{ setTipo(v,$1,$2);setVali(v,$4,$2); istore(v,$2);} 
	| T_TREAL T_VAR T_ATRIB exprREAL 			{ setTipo(v,$1,$2);setValf(v,$4,$2); istore(v,$2);}
	| T_TBOOLEANO T_VAR T_ATRIB T_TRUE			{ setTipo(v,$1,$2);setValv(v,$4,$2);}
	| T_TBOOLEANO T_VAR T_ATRIB T_FALSE	 		{ setTipo(v,$1,$2);setValv(v,$4,$2);}
	| T_VAR T_ATRIB exprINT						{ setVali(v,$3,$1);istore(v,$1);} 
	| T_VAR T_ATRIB exprREAL 					{ setValf(v,$3,$1);istore(v,$1);}
	| T_VAR T_ATRIB T_VAR						{ setValv(v,$3,$1);atribV(v,$1,$3);}
	// | T_VAR T_ATRIB T_TRUE						{ }
	// | T_VAR T_ATRIB T_FALSE	 					{ }
	;

exprINT: T_INT									{bipush($1);} 		
	| exprINT T_PLUS exprINT					{$$=$1+$3; iadd();}
	| exprINT T_MINUS exprINT					{$$=$1-$3; isub();}
	| exprINT T_MULTIPLY exprINT				{$$=$1*$3; imul();}
	| exprINT T_DIVIDE exprINT					{$$=$1/$3; idiv();}
	| T_LEFT exprINT T_RIGHT					{$$=$2;}
	| T_VAR T_PLUS exprINT						{iload(v,$1);$$=atoi(getValVar(v,$1))+$3;iadd();}
	| T_VAR T_MINUS exprINT						{iload(v,$1);$$=atoi(getValVar(v,$1))-$3;isub();}
	| T_VAR T_MULTIPLY exprINT					{iload(v,$1);$$=atoi(getValVar(v,$1))*$3;imul();}
	| T_VAR T_DIVIDE exprINT					{iload(v,$1);$$=atoi(getValVar(v,$1))*$3;idiv();}
	;

exprREAL: T_REAL						{ldcf($1);}	  
	| exprREAL T_PLUS exprREAL 			{$$=$1+$3;fadd();}
	| exprREAL T_MINUS exprREAL 		{$$=$1-$3;fsub();}
	| exprREAL T_MULTIPLY exprREAL		{$$=$1*$3;fmul();}
	| exprREAL T_DIVIDE exprREAL		{$$=$1/$3;fdiv();}
	| T_LEFT exprREAL T_RIGHT			{$$=$2;}
	| exprINT T_PLUS exprREAL 			{$$=$1+$3;fadd();}
	| exprINT T_MINUS exprREAL			{$$=$1-$3;fsub();}
	| exprINT T_MULTIPLY exprREAL		{$$=$1*$3;fmul();}
	| exprINT T_DIVIDE exprREAL			{$$=$1/$3;fdiv();}
	| exprREAL T_PLUS exprINT			{$$=$1+$3;fadd();}
	| exprREAL T_MINUS exprINT			{$$=$1-$3;fsub();}
	| exprREAL T_MULTIPLY exprINT		{$$=$1*$3;fmul();}
	| exprREAL T_DIVIDE exprINT			{$$=$1/$3;fdiv();}
	// | T_VAR T_PLUS exprREAL			
	// | T_VAR T_MINUS exprREAL			
	// | T_VAR T_MULTIPLY exprREAL			
	// | T_VAR T_DIVIDE exprREAL			
	;

relacional: T_VAR T_MAIOR exprINT {ifiti(v,$1,$3);}  	
	| T_VAR T_MENOR exprINT {ifgti(v,$1,$3);}
	| T_VAR T_MAIORE exprINT {ifiei(v,$1,$3);}  
	| T_VAR T_MENORE exprINT {ifgei(v,$1,$3);} 
	| T_VAR T_EQUAL exprINT {ifnei(v,$1,$3);}  
	| T_VAR T_DIF exprINT {ifeqi(v,$1,$3);}  

	|T_VAR T_MAIOR exprREAL {ifitf(v,$1,$3);}  
	| T_VAR T_MENOR exprREAL {ifgtf(v,$1,$3);} 
	| T_VAR T_MAIORE exprREAL {ifief(v,$1,$3);}   
	| T_VAR T_MENORE exprREAL {ifgef(v,$1,$3);} 
	| T_VAR T_EQUAL exprREAL {ifnef(v,$1,$3);}  
	| T_VAR T_DIF exprREAL {ifeqf(v,$1,$3);}
	
	|T_VAR T_MAIOR T_VAR {ifitv(v,$1,$3);}  
	| T_VAR T_MENOR  T_VAR {ifgtv(v,$1,$3);}  
	| T_VAR T_MAIORE T_VAR {ifiev(v,$1,$3);}  
	| T_VAR T_MENORE T_VAR {ifgev(v,$1,$3);} 
	| T_VAR T_EQUAL T_VAR {ifnev(v,$1,$3);}
	| T_VAR T_DIF T_VAR {ifeqv(v,$1,$3);}  

	|T_VAR T_EQUAL T_FALSE { }
	|T_VAR T_EQUAL T_TRUE { }
	|T_VAR T_DIF T_TRUE { }
	|T_VAR T_DIF T_FALSE { }
	;

oplogica:  %empty
	| T_AND relacional oplogica 
	| T_OR relacional oplogica
	;

bloco: T_CE start return T_CD
	;

return: %empty	
	| T_RETURN return_tipo	
	;

return_tipo: T_VAR {printf("RETURN VARIAVEL \n"); }
	| T_TRUE {printf("RETURN TRUE\n"); }
	| T_FALSE {printf("RETURN FALSE\n"); }
	;

entrada: T_SCAN T_LEFT T_VAR T_RIGHT {printf("SCAN LIDO\n"); }
	;

saida: T_PRINT T_LEFT T_VAR T_RIGHT	 {printf("PRINT LIDO\n"); }
	;
	
cond: if else
	;

if: T_IF T_LEFT relacional oplogica T_RIGHT bloco {gotol(); printLabelInvertido(); }
	;

else: %empty
	| T_ELSE cond  {printf("ELSE LIDO\n"); }
	| T_ELSE bloco  {printf("ELSE LIDO\n");}

	
switch: T_SWITCH T_LEFT T_VAR T_RIGHT T_CE switchBloq default T_CD {printf("SWITCH LIDO\n");}
	;

switchBloq: case switchBloq
	|case
	;

case: T_CASE T_INT T_2P start T_BREAK {printf("CASE LIDO\n");}
	;

default : %empty 
	|T_DEFAULT T_2P start T_BREAK  {printf("DEFAULT LIDO\n");}

while: {printLabelWhile();} T_WHILE T_LEFT relacional oplogica T_RIGHT bloco {gotolW();printLabel();}
	| T_DO bloco T_WHILE T_LEFT relacional oplogica T_RIGHT {printf("DO-WHILE LIDO\n");}
	;


for: T_FOR T_VAR T_INRANGE T_VAR bloco {printf("FOR LIDO\n");}
	| T_FOR T_VAR T_INRANGE T_INT bloco {printf("FOR LIDO\n");}
	;

plus: T_VAR T_PP  {plusplus(v,$1);}
	;

minus: T_VAR T_MM {printf("VAR-- LIDO\n"); }
	;

%%



int main(argc, argv) 
	int argc;
	char **argv;
{
	v = list_create();
	++argv, --argc;

	if(argc >0)
		yyin = fopen(argv[0],"r");
	else
		yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	list_delete(v);

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	exit(1);
}