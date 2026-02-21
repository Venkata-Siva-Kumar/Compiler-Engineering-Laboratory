%{
#include<stdio.h>
#include "y.tab.h"
%}

%%
if					{ return IF; }
else				{ return ELSE; }
switch         		{ return SWITCH; }
case           		{ return CASE; }
default        		{ return DEFAULT; }
break          		{ return BREAK; }

[a-zA-Z]+      		{ return ID; }
[0-9]+         		{ return NUM; }

"<="|">="|"<"|">"   { return RE; }
[+\-*/]				{ return OP; }
"\n"				{;}
[ \t]				{;}
.               	{ return yytext[0]; }

%%
