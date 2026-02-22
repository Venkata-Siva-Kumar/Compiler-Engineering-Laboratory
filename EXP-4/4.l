%{
#include "y.tab.h"
%}

%%
int|char|float			{return DT;}
[a-zA-Z_][a-zA-Z0-9_]*	{return ID;}
[0-9]+					{return NUM;}
[+\-*/]					{return OP;}
[ \t\n]+   				;
.						{return yytext[0];}
%%

