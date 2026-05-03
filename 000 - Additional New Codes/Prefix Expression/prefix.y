%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror(char *s);

extern FILE *yyin;
FILE *out;

char *GenCode(char *op, char *left, char *right) {
    char* res = (char*)malloc(100);
    sprintf(res, "%s %s %s", op, left, right);
    return res;
}

%}

%union { char *str; }
%token<str> ID NUM
%type<str> E

%left '+' '-'
%left '*' '/'

%%

S	:	E		{ fprintf(out,"Prefix : %s\n", $1); printf("Prefix : %s\n", $1); };

E	:	E '+' E { $$ = GenCode("+", $1, $3); }
  	|	E '-' E { $$ = GenCode("-", $1, $3); }
  	|	E '*' E { $$ = GenCode("*", $1, $3); }
  	|	E '/' E { $$ = GenCode("/", $1, $3); }
  	|	'(' E ')' { $$ = $2; }
  	|	NUM
  	|	ID
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