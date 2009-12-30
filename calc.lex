/* Lexical Analyser for the Calculator */
%option noyywrap

%{
#define YYSTYPE double     /* type for bison's var: yylval */
#include <stdlib.h>        /* for atof(const char*) */
#include "calc_tab.h"
%}
    

digits [0-9]
number     (0|[1-9]+{digits}*)\.?{digits}* 
op     [+*^/-]
ws     [ \t]+

/* lexer starts here */
%%

{number}   	yylval = atof(yytext); return NUM;
{op}   		| /* do nothing */
\n     		return *yytext;
{ws}   		/* eats up white spaces */

%%