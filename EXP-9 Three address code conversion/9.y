%{

#include <stdio.h>
int yylex();
int yyerror(char *s);


extern FILE *yyin;
FILE *out;

char temp = 'A';
char GenCode(char a, char op, char b) 
{
    fprintf(out,"%c = %c %c %c\n", temp, a, op, b);
    return temp++;
}

%}

%token NUM ID
%left '+' '-'
%left '*' '/'

%%

S	:	E		{ fprintf(out,"Result = %c\n", $1); }	;

E 	:	E '+' E 	{ $$ = GenCode($1, '+', $3); }
 	| 	E '-' E 	{ $$ = GenCode($1, '-', $3); }
 	|	E '*' E 	{ $$ = GenCode($1, '*', $3); }
  	|	E '/' E 	{ $$ = GenCode($1, '/', $3); }
  	|	'(' E ')' 	{ $$ = $2; }
  	|	NUM 		{ $$ = $1; }
  	| 	ID  		{ $$ = $1; }
  	;

%%

int main() 
{
	yyin = fopen("input.txt", "r");  
    out  = fopen("output.txt", "w");
    yyparse();
    fclose(yyin);
	fclose(out);
    return 0;
}
int yywrap() 
{
    return 1;
}
int yyerror(char *s) 
{
    fprintf(out,"Error\n");
    return 0;
}
