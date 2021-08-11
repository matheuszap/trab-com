%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "compilador.tab.h"
#include "list.h"

list *v;
int num_linha = 1;

void yyerror_lex(const char* s) {
	fprintf(stderr, "Erro de análise lexica: %s \n", s);
	exit(1);
}

%}

DIGITO		[0-9]
VAR		[a-zA-Z][a-zA-Z0-9]*
COMENTARIO    ###.*\n

%%

[ \t]  ;
{DIGITO}+"."{DIGITO}* 	{return T_REAL; list_push_back(v, yytext, num_linha); }
{DIGITO}+				{return T_INT;  list_push_back(v, yytext, num_linha); }
"{"						{return T_CE; list_push_back(v, yytext, num_linha); }
"}"						{return T_CD; list_push_back(v, yytext, num_linha); }
":"                     {return T_2P; list_push_back(v, yytext, num_linha); }
";"                     {return T_PV;  list_push_back(v, yytext, num_linha); }
"int"					{return T_TINTEIRO; list_push_back(v, yytext, num_linha); }
"float"					{return T_TREAL; list_push_back(v, yytext, num_linha); }
"bool"					{return T_TBOOLEANO;  list_push_back(v, yytext, num_linha); }
"void"					{return T_VOID; list_push_back(v, yytext, num_linha); }
"="                     {return T_ATRIB; list_push_back(v, yytext, num_linha);}
"=="                    {return T_EQUAL;  list_push_back(v, yytext, num_linha); }
"!="                    {return T_DIF;  list_push_back(v, yytext, num_linha); }
"<="                    {return T_MENORE; list_push_back(v, yytext, num_linha);}
">="                    {return T_MAIORE;  list_push_back(v, yytext, num_linha);}
">"                     {return T_MAIOR;  list_push_back(v, yytext, num_linha);}
"<"                     {return T_MENOR; list_push_back(v, yytext, num_linha);}
"!"                     {return T_NOT; list_push_back(v, yytext, num_linha);}
"&&"                    {return T_AND;  list_push_back(v, yytext, num_linha);}
"||"                    {return T_OR; list_push_back(v, yytext, num_linha);}
"+"						{return T_PLUS;  list_push_back(v, yytext, num_linha);}
"-"						{return T_MINUS;  list_push_back(v, yytext, num_linha);}
"*"						{return T_MULTIPLY;  list_push_back(v, yytext, num_linha);}
"/"						{return T_DIVIDE;  list_push_back(v, yytext, num_linha);}
"%"						{return T_MOD; list_push_back(v, yytext, num_linha);}
"("						{return T_LEFT; list_push_back(v, yytext, num_linha);}
")"						{return T_RIGHT; list_push_back(v, yytext, num_linha);}
"++"                    {return T_PP; list_push_back(v, yytext, num_linha);}
"--"                    {return T_MM; list_push_back(v, yytext, num_linha);}
"true"					{return T_TRUE; list_push_back(v, yytext, num_linha);}
"false"					{return T_FALSE; list_push_back(v, yytext, num_linha);}
"quit"					{return T_QUIT; list_push_back(v, yytext, num_linha);}
"if"					{return T_IF; list_push_back(v, yytext, num_linha);}
"else"					{return T_ELSE; list_push_back(v, yytext, num_linha);}
"do"                    {return T_DO; list_push_back(v, yytext, num_linha);}
"while"					{return T_WHILE; list_push_back(v, yytext, num_linha);}
"for"					{return T_FOR; list_push_back(v, yytext, num_linha);}
"switch"                {return T_SWITCH; list_push_back(v, yytext, num_linha);}
"break"                 {return T_BREAK; list_push_back(v, yytext, num_linha);}
"case"                  {return T_CASE; list_push_back(v, yytext, num_linha);}
"default"               {return T_DEFAULT; list_push_back(v, yytext, num_linha);}
"scan"					{return T_SCAN; list_push_back(v, yytext, num_linha);}
"print" 				{return T_PRINT; list_push_back(v, yytext, num_linha);}
"return"				{return T_RETURN; list_push_back(v, yytext, num_linha);}
{VAR}					{return T_VAR; list_push_back(v, yytext, num_linha);}
"in range"              {return T_INRANGE; list_push_back(v,yytext,num_linha);}
"\n"					{num_linha++;}
{COMENTARIO}            {}
.                       {yyerror_lex("Caractere desconhecido");}

%%

