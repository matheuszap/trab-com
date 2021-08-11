bison -d compilador.y
flex compilador.lex
gcc compilador.tab.c lex.yy.c list.c -o compilador -lm
./compilador teste.txt