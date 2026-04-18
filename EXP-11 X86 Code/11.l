%{
 #include<stdio.h>
 #include<string.h>
 #include "y.tab.h"
%}

%%
[a-z][a-z0-9]*	{ strcpy(yylval.var,yytext); return NAME; }
[+]				{ strcpy(yylval.var,yytext); return PLUS; }
[=]				{ strcpy(yylval.var,yytext); return EQ; }
[-]				{ strcpy(yylval.var,yytext); return MINU; }
[*]				{ strcpy(yylval.var,yytext); return MULTI; }
[/]				{ strcpy(yylval.var,yytext); return DIVI; }
\n               { return '\n'; }    
[ \t]            { /* ignore */ } 
%%


