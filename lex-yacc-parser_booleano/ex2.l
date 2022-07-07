%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
%}

%%
  
  /* variables */
   
[x][1-9][0-9]?    {
                   yylval = *yytext - 1;
	           return VARIABLE;
	         }
   
   /* binaries */
   
[0-1]  {
          yylval = atoi(yytext);
	  return BINARY;
       }
   
   /* operators */
   
[+\.!<>=()\n]    { return *yytext; }

"=>"            return IMPLIES;
"<=>"           return EQUIVALENT;

   /* True expressions */
   
"t"|"true"|"v"|"verdadeiro"       return TRUE; 

   /* False expressions */
      
"f"|"false"|"falso"               return FALSE;     
      
   /* skip whitespace */
   
[ \t] ;
   
   /* anything else is an error */
   
. yyerror("invalid character");
					  
%%

  int yywrap(void) {
     return 1;
}					  