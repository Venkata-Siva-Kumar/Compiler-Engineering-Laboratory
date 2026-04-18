%{
#include<stdio.h>
#include "y.tab.h"
%}

%%
if						{return IF;}
else					{return ELSE;}

[0-9]+					{ yylval.num = atoi(yytext); return NUM; }
[a-zA-Z]+				{ yylval.str = strdup(yytext); return ID; }
"=="					{return RE;}
[ \t\n]+				;
.						{return yytext[0];}

%%

