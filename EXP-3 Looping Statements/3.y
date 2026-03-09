%{
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror(char*);
%}

%token FO WH DO DT ID NUM RE INC OP

%%
S : LOOP													{ printf("Exiting\n"); exit(0); };

LOOP : FORLOOP | WHILELOOP | DOWHILELOOP 					;

FORLOOP : FO '(' INIT ';' COND ';' INCREXP ')' BLOCK		{ printf("For Loop Recognized\n"); };

WHILELOOP : WH '(' COND ')' BLOCK							{ printf("While Loop Recognized\n"); };

DOWHILELOOP : DO BLOCK WH '(' COND ')' ';'					{ printf("Do While Loop Recognized\n"); };

BLOCK : '{' BODY '}' ;

BODY : BODY STMT
     | BODY LOOP
     | /* empty */
     ;

INIT : DT ID '=' NUM										;

COND : ID RE NUM | ID RE ID									;

INCREXP : ID INC											;

STMT : ID '=' ID OP ID ';'	| ID INC ';'					;
     
%%

int main()
{
	yyparse(); 
	return 0;
}
int yywrap()
{
	return 1;
}
int yyerror(char *s) 
{
	printf("%s",s);
	
}
