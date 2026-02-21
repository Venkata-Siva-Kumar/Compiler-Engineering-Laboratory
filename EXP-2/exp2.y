%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror(char*);
%}

%token IF ELSE ID NUM RE OP
%token SWITCH CASE DEFAULT BREAK

%%

STMT : statement       											{ printf("Input Recognized\n"); YYACCEPT;};
statement :	if_stmt | switch_stmt								;

/* IF STMT */
if_stmt : IF '(' cond ')' block
		 |IF '(' cond ')' block ELSE block
		 |IF '(' cond ')' block ELSE if_stmt;
		  
cond : ID RE NUM												;

block: '{' stmt_list '}'										;

stmt_list : stmt_list stmt | stmt								;

stmt : assign | if_stmt	| switch_stmt							;

assign : ID '=' NUM ';' 										;

/* SWITCH CASE */
switch_stmt : SWITCH '(' ID ')' '{' case_list default_stmt '}'	;

case_list : case_list case_stmt | case_stmt						;

case_stmt : CASE NUM ':' stmt BREAK ';' 						;

default_stmt :	DEFAULT ':' stmt |      						;
%%

int main()
{
	printf("Enter a statement : ");
	yyparse(); 
	return 0;
}
int yywrap()
{
	return 1;
}
int yyerror(char *s) 
{
	printf("Invalid Input\n");
}
