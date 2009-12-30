/* Parser FILE FOR Calculator */
%{
#define YYSTYPE double
#include <math.h>
%}

%token NUM

%% /* Grammer rules and actions follow */

input: /* empty */
     | input line { printf("calc >"); }
     ;

line: '\n'
    | E '\n' { printf("ANS:%.10g\n", $1); }
    ;

/* AMBIGUITY RESOLVED GRAMMAR 

	E -> E + T | E - T | T
	T -> T * P | T / P | P
	P -> P ^ M | M
	M -> - M | F
	F -> NUM | ( E )
	
	Here 
	
	M -> Unary Minus i.e -2 , -4.5 etc
	P -> Power i.e 2 ^ 3, 4 ^ 5 etc.
	
	
*/

E	:	E '+' T { $$ = $1 + $3; }
	|	E '-' T { $$ = $1 - $3; }
	|	T
	;

T	:	T '*' P { $$ = $1 * $3; }
	|	T '/' P { $$ = $1 / $3; }
	|	P


P	:	P '^' M { $$ = pow($1, $3); }
	|	M

M	:	'-' M { $$ = -$2; }
	|	F
	;

F	:	NUM { $$ = $1; } 
	|	'(' E ')' { $$ = $2; }
	;

%%

/* Additional C code */

int main() { 
	printf( "Help:\n + => addition ( a + b )\n - -> subtraction ( a - b ) and ( -a )\n * -> multiplication ( a * b )\n / -> division ( a / b )\n ^ -> power ( a ^ b ) \n " );
	printf("calc >"); 
	return yyparse(); 
}

int yyerror(const char* s)
{
	printf("%s\n", s);
	return 0;
}
