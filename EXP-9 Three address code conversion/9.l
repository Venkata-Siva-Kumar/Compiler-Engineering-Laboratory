%{
#include "y.tab.h"
%}

%%
[0-9]      { yylval = yytext[0]; return NUM; }
[a-z]      { yylval = yytext[0]; return ID; }
\n         { return 0; }
.          { return yytext[0]; }
%%


