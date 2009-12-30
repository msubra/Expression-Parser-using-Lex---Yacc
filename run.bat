set NAME=calc
set GRAMMAR=%NAME%.y

flex %NAME%.lex
bison -d %GRAMMAR%

gcc %NAME%_tab.c lex.yy.c -o calc
del *.c *.h