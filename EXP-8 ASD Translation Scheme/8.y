%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int yylex();
int yyerror(char*);
%}

%union{ int num; char *str; }
%token IF ELSE RE
%token <str> ID
%token <num> NUM

%%

S		:	IF '(' ID RE NUM ')'
														{
															printf("\nEquivalent Switch Case: \n");
															printf("switch(%s)\n{\n",$3);
															printf("\tcase %d: ",$5);
														}
	 		STMT EL
    	;

STMT	:	ID '=' NUM ';' 								{ printf("\n\t\t%s = %d;\n\t\tbreak;\n",$1,$3); };

EL		:	ELSE IF '(' ID RE NUM ')' 					{ printf("\tcase %d: ",$6); }
	 		STMT EL
		| 
			ELSE 										{ printf("\tdefault: "); } 
			STMT 										{ printf("}\n"); exit(0); }
		;	 
%%

int main()
{
	printf("Enter the Statement in if-else: ");
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
