%{
#include <stdio.h>
void yyerror(char *);
int yylex(void);
	    
int sym[99];
%}
		
%token BINARY VARIABLE IMPLIES EQUIVALENT TRUE FALSE
		
%left '+' '.' IMPLIES EQUIVALENT
%left '!'
		
%%
		
program:
     program statement '\n'
     | /* NULL */
     ;
    
statement:
    expression
    { printf("%d\n", $1); }
    | VARIABLE '=' expression       { sym[$1] = $3; }
    ;
    
expression:		              
    BINARY
    | TRUE                             { $$ = 1 ;}
    | FALSE                            { $$ = 0 ;}
    | VARIABLE                         { $$ = sym[$1]; }
    | '!'expression                    { if($2 == 0){$$ = 1;} else{$$ = 0;} }
    | expression '+' expression        { if($1 + $3 == 2){$$ = 1;} else{$$ = $1 + $3;} }
    | expression '.' expression        { $$ = $1 * $3; }
    | expression IMPLIES expression    { if($1 == 1 && $3 == 0){$$ = 0;} else{$$ = 1;} }
    | expression EQUIVALENT expression { if($1 == $3){$$ = 1;} else{$$ = 0;} }
    | '(' expression ')'               { $$ = $2; }
    ;
			
%%			

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
}		