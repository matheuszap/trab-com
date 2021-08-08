%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "compilador.tab.h"
#include "list.h"

list *lista;
int num_linha = 1;

%}

DIGITO		[0-9]
VAR		[a-zA-Z][a-zA-Z0-9]*

%%

[ \t]  ;
{DIGITO}+"."{DIGITO}* 	{return T_REAL; }
{DIGITO}+				{return T_INT;  }
"{"						{return T_CE; }
"}"						{return T_CD; }
":"                     {return T_2P; }
";"                     {return T_PV;  }
"int"					{return T_TINTEIRO; }
"float"					{return T_TREAL; }
"bool"					{return T_TBOOLEANO;  }
"void"					{return T_VOID; }
"="                     {return T_ATRIB; }
"=="                    {return T_EQUAL;  }
"!="                    {return T_DIF;  }
"<="                    {return T_MENORE; }
">="                    {return T_MAIORE;  }
">"                     {return T_MAIOR;  }
"<"                     {return T_MENOR; }
"!"                     {return T_NOT; }
"&&"                    {return T_AND;  }
"||"                    {return T_OR; }
"+"						{return T_PLUS;  }
"-"						{return T_MINUS;  }
"*"						{return T_MULTIPLY;  }
"/"						{return T_DIVIDE;  }
"%"						{return T_MOD; }
"("						{return T_LEFT; }
")"						{return T_RIGHT; }
"++"                    {return T_PP; }
"--"                    {return T_MM; }
"true"					{return T_TRUE; }
"false"					{return T_FALSE; }
"quit"					{return T_QUIT; }
"if"					{return T_IF; }
"else"					{return T_ELSE; }
"do"                    {return T_DO; }
"while"					{return T_WHILE; }
"for"					{return T_FOR; }
"switch"                {return T_SWITCH; }
"break"                 {return T_BREAK; }
"case"                  {return T_CASE; }
"default"               {return T_DEFAULT; }
"scan"					{return T_SCAN; }
"print" 				{return T_PRINT; }
"return"				{return T_RETURN; }
{VAR}					{return T_VAR; }
"\n"					{++num_linha; return T_NEWLINE; }

%%

