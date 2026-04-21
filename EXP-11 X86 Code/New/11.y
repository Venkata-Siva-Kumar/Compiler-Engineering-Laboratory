%{
#include<stdio.h>
#include<string.h>

extern FILE *yyin;
FILE *fout;
int yylex();
void yyerror();

%}

%token<var> NAME
%type<var> exp
%union{ char var[10]; }

%right '='
%left '+' '-'
%left '*' '/'

%%

input	:	input line '\n'
		|	input line
		|
		;

line	:	NAME '=' exp {fprintf(fout,"STA %s\n",$1);}
		;

exp		:	NAME '+' NAME			{ fprintf(fout,"LDA %s\nLDT %s\nADDR A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME '-' NAME			{ fprintf(fout,"LDA %s\nLDT %s\nSUBR  A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME '*' NAME			{ fprintf(fout,"LDA %s\nLDT %s\nMULR A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME '/' NAME			{ fprintf(fout,"LDA %s\nLDT %s\nDIVR A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME 					{ fprintf(fout,"LDA %s\n",$1); strcpy($$,$1); }
		;

%%

int main()
{
	yyin=fopen("input.txt","r");
	fout=fopen("out.txt","w");
	yyparse();
	fclose(yyin);
	fclose(fout);
	return 0;
}

int yywrap() 
{
	return 1;
}
void yyerror()
{
	printf("Error\n");
}



