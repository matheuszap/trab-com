bison -d compilador.y
flex compilador.lex
gcc compilador.tab.c lex.yy.c -o compilador -lm
./compilador