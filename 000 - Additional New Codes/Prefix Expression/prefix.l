%{
#include<stdio.h>
#include "y.tab.h"
%}

%%
[a-z]+		{ yylval.str = strdup(yytext); return ID; }
[0-9]+		{ yylval.str = strdup(yytext); return NUM; }
[ \t\n]+	{;}
.			{ return yytext[0]; } 
%%
