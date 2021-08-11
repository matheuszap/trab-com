%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "list.h"
#include "escrita.h"

extern int yylex();
extern int yyparse();
extern FILE* yyin;
extern list *v;


void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
	char* sval;
}

%token<ival> T_INT
%token<fval> T_REAL
%token<sval> T_VAR T_TINTEIRO T_TREAL T_TBOOLEANO T_CONST T_TRUE T_FALSE
%token T_LEFT T_RIGHT T_COLE T_COLD							
%token T_OR T_AND T_NOT						
%token T_EQUAL T_DIF T_MENORE T_MAIORE T_MAIOR T_MENOR		
%token T_ATRIB T_PV T_NEWLINE T_QUIT							
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_MOD T_PLUS_PLUS  			
%token T_VOID							
%token T_IF T_ELSE T_WHILE T_FOR 
%token T_SCAN T_PRINT T_ABS T_MAX T_MIN T_RETURN

%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<fval> exprREAL
%type<ival> exprINT 


%start compC

%%

compC: {cabecalho();} line  
	;


line: 				
	| T_QUIT T_NEWLINE					{final();list_delete(v);exit(0);}							
	| atrib final
	| declaracao final
	| condif final
	| while final
	| for final
	| func final
	| funcES final
	| funcPERS final
	| maismais final
	;

final:  T_NEWLINE line
	;
			
exprREAL: T_REAL						{ldcf($1);}	    
	| exprREAL T_PLUS exprREAL			{$$=$1+$3;fadd();}						
	| exprREAL T_MINUS exprREAL			{$$=$1-$3;fsub();}				
	| exprREAL T_MULTIPLY exprREAL		{$$=$1*$3;fmul();}		
	| exprREAL T_DIVIDE exprREAL		{$$=$1/$3;fmul();}			
	| T_LEFT exprREAL T_RIGHT			{$$=$2;}	
	| exprINT T_PLUS exprREAL			{$$=$1+$3;fadd();}		
	| exprINT T_MINUS exprREAL			{$$=$1-$3;fsub();}
	| exprINT T_MULTIPLY exprREAL		{$$=$1*$3;fmul();}
	| exprINT T_DIVIDE exprREAL			{$$=$1/$3;fdiv();}
	| exprREAL T_PLUS exprINT			{$$=$1+$3;fadd();}
	| exprREAL T_MINUS exprINT			{$$=$1-$3;fsub();}
	| exprREAL T_MULTIPLY exprINT		{$$=$1*$3;fmul();}
	| exprREAL T_DIVIDE exprINT			{$$=$1/$3;fdiv();}
	| exprINT T_DIVIDE exprINT			{$$=$1/$3;idiv();}
	| T_VAR T_PLUS T_VAR				{iload(v,$1);iload(v,$3);$$=atof(getValVar(v,$1))+atof(getValVar(v,$3));iadd();}
	| T_VAR T_MINUS T_VAR				{iload(v,$1);iload(v,$3);$$=atof(getValVar(v,$1))-atof(getValVar(v,$3));isub();}
	| T_VAR T_MULTIPLY T_VAR			{iload(v,$1);iload(v,$3);$$=atof(getValVar(v,$1))*atof(getValVar(v,$3));imul();}
	| T_VAR T_DIVIDE T_VAR				{iload(v,$1);iload(v,$3);$$=atof(getValVar(v,$1))/atof(getValVar(v,$3));idiv();}
	;

exprINT: T_INT						{bipush($1);}  
	| exprINT T_PLUS exprINT		{$$=$1+$3; iadd();}			
	| exprINT T_MINUS exprINT		{$$=$1-$3;isub();}
	| exprINT T_MULTIPLY exprINT		{$$=$1*$3;imul();}		
	| T_LEFT exprINT T_RIGHT		{$$=$2;}
	| T_VAR T_PLUS exprINT			{iload(v,$1);$$=atoi(getValVar(v,$1))+$3;iadd();}		
	| T_VAR T_MINUS exprINT			{iload(v,$1);$$=atoi(getValVar(v,$1))-$3;isub();}		
	| T_VAR T_MULTIPLY exprINT		{iload(v,$1);$$=atoi(getValVar(v,$1))*$3;imul();}
	;


relac: T_VAR T_EQUAL exprINT                  {ifnei(v,$1,$3);}           		
    	| T_VAR T_MAIOR exprINT                	{ifiti(v,$1,$3);}  	
    	| T_VAR T_MAIORE exprINT                {ifiei(v,$1,$3);}  		
    	| T_VAR T_DIF exprINT                   {ifeqi(v,$1,$3);}   		
    	| T_VAR T_MENOR exprINT                	{ifgti(v,$1,$3);}  	
    	| T_VAR T_MENORE exprINT                {ifgei(v,$1,$3);}  
		| T_VAR T_EQUAL exprREAL                	{ifnef(v,$1,$3);}  	
    	| T_VAR T_MAIOR exprREAL                {ifitf(v,$1,$3);}  		
    	| T_VAR T_MAIORE exprREAL               {ifief(v,$1,$3);}   		
    	| T_VAR T_DIF exprREAL                  {ifeqf(v,$1,$3);}    		
    	| T_VAR T_MENOR exprREAL                {ifgtf(v,$1,$3);}  		
    	| T_VAR T_MENORE exprREAL               {ifgef(v,$1,$3);}  
		| T_VAR T_EQUAL T_VAR                		  {ifnev(v,$1,$3);}  
    	| T_VAR T_MAIOR T_VAR                		{ifitv(v,$1,$3);}  
    	| T_VAR T_MAIORE T_VAR                	{ifiev(v,$1,$3);}  	
    	| T_VAR T_DIF T_VAR                    	{ifeqv(v,$1,$3);}  	
    	| T_VAR T_MENOR T_VAR                		{ifgtv(v,$1,$3);}  
    	| T_VAR T_MENORE T_VAR                  {ifgev(v,$1,$3);}  
		| exprINT T_EQUAL T_VAR                		{ifnei(v,$3,$1);}  
    	| exprINT T_MAIOR T_VAR                	{ifiti(v,$3,$1);}  	
    	| exprINT T_MAIORE T_VAR                {ifiei(v,$3,$1);}  		
    	| exprINT T_DIF T_VAR                   {ifeqi(v,$3,$1);}  		
    	| exprINT T_MENOR T_VAR                	{ifgti(v,$3,$1);}  	
    	| exprINT T_MENORE T_VAR                {ifgei(v,$3,$1);}  
		| exprREAL T_EQUAL T_VAR                	{ifnef(v,$3,$1);}  	
    	| exprREAL T_MAIOR T_VAR                {ifitf(v,$3,$1);}  		
    	| exprREAL T_MAIORE T_VAR               {ifief(v,$3,$1);}   		
    	| exprREAL T_DIF T_VAR                  {ifeqf(v,$3,$1);}    		
    	| exprREAL T_MENOR T_VAR                {ifgtf(v,$3,$1);}  		
    	| exprREAL T_MENORE T_VAR               {ifgef(v,$3,$1);}     		
    	;

atrib: T_TINTEIRO T_VAR T_ATRIB exprINT					{setTipo(v,$1,$2);setVali(v,$4,$2);atribI2(v,$2);}
	| T_TREAL T_VAR T_ATRIB exprREAL					{setTipo(v,$1,$2);setValf(v,$4,$2);atribF2(v,$2);}
	| T_TBOOLEANO T_VAR T_ATRIB T_TRUE					{setTipo(v,$1,$2);setValv(v,$4,$2);}
	| T_TBOOLEANO T_VAR T_ATRIB T_FALSE  					{setTipo(v,$1,$2);setValv(v,$4,$2);}
	| T_TINTEIRO T_VAR T_ATRIB T_VAR					{setTipo(v,$1,$2);setValv(v,$4,$2);atribV(v,$2,$4);}
	| T_TREAL T_VAR T_ATRIB T_VAR						{setTipo(v,$1,$2);setValv(v,$4,$2);atribV(v,$2,$4);}
	| T_TBOOLEANO T_VAR T_ATRIB T_VAR					{setTipo(v,$1,$2);setValv(v,$4,$2);}
	| T_VAR T_ATRIB exprINT						{setVali(v,$3,$1);atribI2(v,$1);}
	| T_VAR T_ATRIB T_VAR							{setValv(v,$3,$1);atribV(v,$1,$3);}
	| T_VAR T_ATRIB exprREAL						{setValf(v,$3,$1);atribF2(v,$1);}
	;

declaracao: T_TINTEIRO T_VAR							{setTipo(v,$1,$2);}
	| T_TREAL T_VAR							{setTipo(v,$1,$2);}
	| T_TBOOLEANO T_VAR							{setTipo(v,$1,$2);}
	;
	
oplog: T_VAR T_AND T_VAR                
      | T_VAR T_AND exprINT             
      | T_VAR T_AND exprREAL            
      | exprINT T_AND T_VAR            
      | exprREAL T_AND T_VAR            
      | T_VAR T_OR T_VAR                
      | T_VAR T_OR exprINT             
      | T_VAR T_OR exprREAL            
      | exprINT T_OR T_VAR            
      | exprREAL T_OR T_VAR             
      ;

condif: T_IF T_LEFT cond T_RIGHT blocoinstr					{printLabel();}
	| T_IF T_LEFT cond T_RIGHT blocoinstr {gotol();printLabelInvertido();} else	    {printLabel();}			
	;
		
else: T_ELSE blocoinstr							
	;

cond:
    	| oplog
    	| relac
    	| T_OR or
	| T_AND and
    	;
and: oplog cond
	| relac cond
	;
or: oplog cond
	| relac cond
	;

while: {printLabelWhile();} T_WHILE T_LEFT cond T_RIGHT blocoinstr				{gotolW();printLabel();}
	;									
    	
for: T_FOR T_LEFT atrib T_PV relac T_PV maismais T_RIGHT blocoinstr		
    	| T_FOR T_LEFT atrib T_PV oplog T_PV maismais T_RIGHT blocoinstr	
    	;

func: T_VOID T_VAR T_LEFT arg T_RIGHT blocoinstr				
	| T_TINTEIRO T_VAR T_LEFT arg T_RIGHT blocoinstr			
	| T_TREAL T_VAR T_LEFT arg T_RIGHT blocoinstr				
	| T_TBOOLEANO T_VAR T_LEFT arg T_RIGHT blocoinstr			
	;
	
funcES: T_SCAN T_LEFT T_VAR T_RIGHT 						
	| T_PRINT T_LEFT T_VAR T_RIGHT 					{printart(v,$3);printf("PRINT LIDO\n");}
	;
 
funcPERS: T_VAR T_ATRIB T_ABS T_LEFT T_VAR T_RIGHT 				{funcabs(v,getValVar(v,$5),getIdVar(v,$1));}
	| T_VAR T_ATRIB T_ABS T_LEFT exprINT T_RIGHT 				
	| T_VAR T_ATRIB T_ABS T_LEFT exprREAL T_RIGHT 				
	| T_VAR T_ATRIB T_MAX T_LEFT T_VAR T_PV T_VAR T_RIGHT 		{funcmax(v,getValVar(v,$5),getValVar(v,$7),getIdVar(v,$1));}				
	| T_VAR T_ATRIB T_MIN T_LEFT T_VAR T_PV T_VAR T_RIGHT 		{funcmin(v,getValVar(v,$5),getValVar(v,$7),getIdVar(v,$1));}				
	;
	
arg: 										
	| T_TINTEIRO T_VAR T_PV arg						
	| T_TREAL T_VAR T_PV arg							
	| T_TBOOLEANO T_VAR T_PV arg						
	;
	

blocoinstr:  T_COLE final return T_COLD  					
	;	
	
return: 
	| T_RETURN returnCont								
	;
returnCont: T_INT
	| T_REAL
	| T_TRUE
	| T_FALSE
	| T_VAR
	;

	
// var: T_VAR
// 	;
	
maismais: T_VAR T_PLUS_PLUS				{maismais(v,$1);}
    	;
	
%%

int main(argc, argv)
int argc;
char **argv;
{
	v=list_create();
	// yyin = stdin;
	// yyin = fopen("codigo.lang",'r');
	++argv, --argc;
	if ( argc > 0 )
	yyin = fopen( argv[0], "r" );
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
