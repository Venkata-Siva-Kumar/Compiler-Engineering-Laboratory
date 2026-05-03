%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h> 
#include "y.tab.h"
%}

%%
switch					{ return SWITCH; }
case					{ return CASE; }	
default					{ return DEFAULT; }
break					{ return BREAK; }
[0-9]+					{ yylval.num = atoi(yytext); return NUM; }
[a-zA-Z]+				{ yylval.str = strdup(yytext); return ID; }
[ \t\n]+				{;}
.						{ return yytext[0]; } 
%%
