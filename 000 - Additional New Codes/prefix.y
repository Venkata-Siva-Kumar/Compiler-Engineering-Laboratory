%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror(char *s);

extern FILE *yyin;
FILE *out;
%}

%union { char *str; }
%token<str> ID NUM
%type  <str> E

%left '+' '-'
%left '*' '/'

%%

S	:	E				{ fprintf(out,"Prefix : %s\n", $1); printf("Prefix : %s\n", $1); };

E	:	E '+' E			{ $$ = (char*)malloc(100); sprintf($$, "+ %s %s", $1, $3); }
	|	E '-' E			{ $$ = (char*)malloc(100); sprintf($$, "- %s %s", $1, $3); }
	|	E '*' E			{ $$ = (char*)malloc(100); sprintf($$, "* %s %s", $1, $3); }
	|	E '/' E			{ $$ = (char*)malloc(100); sprintf($$, "/ %s %s", $1, $3); }
	|	'('	E ')'		{ $$ = $2; }
	|	NUM				{ $$ = $1; }
	|	ID				{ $$ = $1; }
	;
%%


int main()
{
	printf("Input Reading from file ... \n");
    yyin = fopen("input.txt", "r");
    out  = fopen("output.txt", "w");
    yyparse();
    fclose(yyin);
    fclose(out);
    return 0;
}

int yyerror(char *s)
{
    printf("Invalid Syntax\n");
    return 0;
}

int yywrap()
{
    return 1;
}
