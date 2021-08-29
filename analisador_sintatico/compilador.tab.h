/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_COMPILADOR_TAB_H_INCLUDED
# define YY_YY_COMPILADOR_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_INT = 258,
    T_REAL = 259,
    T_VAR = 260,
    T_TINTEIRO = 261,
    T_TREAL = 262,
    T_TBOOLEANO = 263,
    T_TRUE = 264,
    T_FALSE = 265,
    T_LEFT = 266,
    T_RIGHT = 267,
    T_CE = 268,
    T_CD = 269,
    T_OR = 270,
    T_AND = 271,
    T_NOT = 272,
    T_EQUAL = 273,
    T_DIF = 274,
    T_MENORE = 275,
    T_MAIORE = 276,
    T_MAIOR = 277,
    T_MENOR = 278,
    T_ATRIB = 279,
    T_PV = 280,
    T_2P = 281,
    T_QUIT = 282,
    T_PLUS = 283,
    T_MINUS = 284,
    T_MULTIPLY = 285,
    T_DIVIDE = 286,
    T_MOD = 287,
    T_PP = 288,
    T_MM = 289,
    T_VOID = 290,
    T_IF = 291,
    T_ELSE = 292,
    T_DO = 293,
    T_WHILE = 294,
    T_FOR = 295,
    T_SWITCH = 296,
    T_CASE = 297,
    T_DEFAULT = 298,
    T_BREAK = 299,
    T_INRANGE = 300,
    T_SCAN = 301,
    T_PRINT = 302,
    T_RETURN = 303
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 20 "compilador.y"

	int ival;
	float fval;
	char *sval;

#line 112 "compilador.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COMPILADOR_TAB_H_INCLUDED  */
