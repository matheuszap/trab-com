%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "compilador.tab.h"
#include "list.h"

list *v;
int line_num = 1;

%}

DIGITO		[0-9]
VAR		[a-zA-Z][a-zA-Z0-9]*

%%

[ \t]	;
{DIGITO}+\.{DIGITO}+ 				{yylval.fval = atof(yytext);list_push_back(v,yytext,line_num,"float",0,yylval.fval,"");return T_REAL;}
{DIGITO}+					{yylval.ival = atoi(yytext);list_push_back(v,yytext,line_num,"int",yylval.ival,0,"");return T_INT;}
"{"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_COLE;}
"}"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_COLD;}
";"                        			{list_push_back(v,yytext,line_num,"",0,0,"");return T_PV;}
"int"						{yylval.sval = strdup(yytext);list_push_back(v,yytext,line_num,"",0,0,"");return T_TINTEIRO;}
"float"					{yylval.sval = strdup(yytext);list_push_back(v,yytext,line_num,"",0,0,"");return T_TREAL;}
"bool"						{yylval.sval = strdup(yytext);list_push_back(v,yytext,line_num,"",0,0,"");return T_TBOOLEANO;}
"const"                        		{yylval.sval = strdup(yytext);list_push_back(v,yytext,line_num,"",0,0,"");return T_CONST;}
"void"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_VOID;}
"="                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_ATRIB;}
"=="                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_EQUAL;}
"!="                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_DIF;}
"<="                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_MENORE;}
">="                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_MAIORE;}
">"                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_MAIOR;}
"<"                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_MENOR;}
"!"                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_NOT;}
"&&"                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_AND;}
"||"                            		{list_push_back(v,yytext,line_num,"",0,0,"");return T_OR;}
"\n"						{++line_num; return T_NEWLINE;}
"+"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_PLUS;}
"-"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_MINUS;}
"*"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_MULTIPLY;}
"/"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_DIVIDE;}
"%"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_MOD;}
"("						{list_push_back(v,yytext,line_num,"",0,0,"");return T_LEFT;}
")"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_RIGHT;}
"++"                        			{list_push_back(v,yytext,line_num,"",0,0,"");return T_PLUS_PLUS;}
"true"						{yylval.sval = strdup(yytext);list_push_back(v,yytext,line_num,"",0,0,yytext);return T_TRUE;}
"false"					{yylval.sval = strdup(yytext);list_push_back(v,yytext,line_num,"",0,0,yytext);return T_FALSE;}
"quit"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_QUIT;}
"if"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_IF;}
"else"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_ELSE;}
"while"					{list_push_back(v,yytext,line_num,"",0,0,"");return T_WHILE;}
"for"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_FOR;}
"scan_int"					{list_push_back(v,yytext,line_num,"",0,0,"");return T_SCAN;}
"print_int"					{list_push_back(v,yytext,line_num,"",0,0,"");return T_PRINT;}
"abs"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_ABS;}
"max"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_MAX;}
"min"						{list_push_back(v,yytext,line_num,"",0,0,"");return T_MIN;}
"return"					{list_push_back(v,yytext,line_num,"",0,0,"");return T_RETURN;}
{VAR}						{yylval.sval = strdup(yytext);list_push_back_var(v,yytext,line_num,"",0,0,"") ;return T_VAR;}

%%
