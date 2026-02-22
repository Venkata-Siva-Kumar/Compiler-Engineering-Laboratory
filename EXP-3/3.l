%{
#include<stdio.h>
#include "y.tab.h"
%}

%%
"for"                   		{ return FO; }
"while"                 		{ return WH; }
"do"                    		{ return DO; }
"int"                   		{ return DT; }
[a-zA-Z]+						{ return ID; }
[0-9]+							{ return NUM; }
"<="|">="|"=="|"!="|"<"|">" 	{ return RE; }
"++"|"--"               		{ return INC; }

[+\-*/]                 		{ return OP; }
[ \t\r\n]                 		{ ; }
.								{return yytext[0];}

%%
