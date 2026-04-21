%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
%}

%%
[a-z][a-z0-9]*   { strcpy(yylval.var, yytext); return NAME; }
[+\-*/=]         { return yytext[0]; }
\n               { return '\n'; }
[ \t]            ;
%%
