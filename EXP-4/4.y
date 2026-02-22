%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror(char *s);
%}

%token ID NUM DT OP

%%
Program : Declaration										{ printf("Valid Procedure Declaration\n"); exit(0); }
        | Definition										{ printf("Valid Procedure Definition\n"); exit(0); }
        ;

Declaration		: Header ';'									;
Definition 		: Header '{' Statement '}'						;

Header	   		: DT ID '(' ParameterList ')'					;

ParameterList	: Parameter | Parameter ',' ParameterList  |	;
Parameter		: DT ID ArrayPart								;
ArrayPart		: ArrayPart '[' NUM ']'	| 						;


Statement 		: ID '=' Expr ';'								;

Expr	: Expr OP Expr | ID | NUM								;

%%

int main()
{
    printf("Enter procedure:\n");
    yyparse();
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
