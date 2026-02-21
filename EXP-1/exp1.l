%{
#include<stdio.h>
%}

%%

int|float|main|while|sizeof|if|else		{printf("Keyword : %s\n",yytext);}
[a-zA-Z][a-zA-Z0-9]*					{printf("Identifier : %s\n",yytext);}
[0-9]+\.[0-9]+							{printf("Floating Constant : %s\n",yytext);}
[0-9]+									{printf("Integer Constant : %s\n",yytext);}
"+"|"-"|"*"|"/"|"<"|">"|"="				{printf("Operator : %s\n",yytext);}
[(){};,]								{printf("Seperator : %s\n",yytext);}
[\t\n]									;
.										{printf("Special Symbols : %s\n",yytext);}
%%

int main()
{
	yylex(); 
	return 0;
}
int yywrap() 
{
	return 1;
}

/*
Compilation Steps

lex exp1.l
cc lex.yy.c
./a.out

*/
