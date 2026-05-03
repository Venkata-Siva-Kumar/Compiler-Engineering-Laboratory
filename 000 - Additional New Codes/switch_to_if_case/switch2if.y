%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
int yyerror(char*);

char *var;
%}

%union{ int num; char *str; }
%token SWITCH CASE DEFAULT BREAK
%token <str> ID
%token <num> NUM

%%

S		:	SWITCH '(' ID ')'	{ var = $3; } '{' CASE NUM ':'
																{
																	printf("\nEquivalent if case:\n");
																	printf("if(%s==%d)\n{\n", var, $8);
																}
			STMT BREAK ';' EL
		;

STMT	:	ID '=' NUM ';'										{	printf("\t%s = %d;\n", $1, $3); } ;

EL		:	CASE NUM ':' 										{ printf("}\nelse if(%s==%d)\n{\n", var, $2); }
			STMT BREAK ';' EL
		
    	|	DEFAULT												{	printf("}\nelse\n{\n");	}
        	STMT												{	printf("}\n"); exit(0); }

;	 

%%

int main()
{
	printf("Enter the Statement in switch-case statement: ");
	yyparse(); 
	return 0;
}
int yywrap()
{
	return 1;
}
int yyerror(char *s) 
{
	printf("Error : %s\n",s);
}
