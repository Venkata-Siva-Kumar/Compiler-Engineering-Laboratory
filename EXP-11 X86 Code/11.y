%{
#include<stdio.h>
#include<string.h>
#include<ctype.h>
 
FILE *fout;
int yylex();
void yyerror();

%}

%token<var> NAME PLUS MINU EQ MULTI DIVI
%type<var> exp
%union{ char var[10]; }

%right EQ
%left PLUS MINU
%left MULTI DIVI

%%

input	:	line '\n' input
		|	'\n' input
		| /*empty*/
		;

line	:	NAME EQ exp {fprintf(fout,"STA %s\n",$1);}
		;

exp		:	NAME PLUS NAME			{ fprintf(fout,"LDA %s\nLDT %s\nADDR A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME MINU NAME			{ fprintf(fout,"LDA %s\nLDT %s\nSUBR  A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME MULTI NAME			{ fprintf(fout,"LDA %s\nLDT %s\nMULR A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME DIVI NAME			{ fprintf(fout,"LDA %s\nLDT %s\nDIVR A,T\n",$1,$3); strcpy($$, $1); }
		|	NAME 					{ fprintf(fout,"LDA %s\n",$1); strcpy($$,$1); }
		;

%%

void yyerror()
{
 printf("\nError ");
}

int yywrap() 
{
	return 1;
}

extern FILE *yyin;

int main()
{
	FILE *fin;
	fin=fopen("input.txt","r");
	fout=fopen("out.txt","w");
	yyin=fin;
	yyparse();
	fclose(fin);
	fclose(fout);
	return 0;
}



