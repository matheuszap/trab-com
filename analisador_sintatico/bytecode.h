#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"

list *l;

void header(){
	l = list_create();

	FILE *arquivo;
 	if ((arquivo=fopen("output.j","w"))==NULL){
 		return;
 	}
 	else{
 		fprintf(arquivo,".class public Teste\n.super java/lang/Object\n\n");
 		fprintf(arquivo,".method public <init>()V\naload_0\ninvokenonvirtual java/lang/Object/<init>()V\nreturn\n.end method\n\n");
 		fprintf(arquivo,".method public static main([Ljava/lang/String;)V\n.limit stack 100\n.limit locals 100\n");
 		fclose(arquivo);
 	}	
}

void print(char* saida){
	FILE *arquivo;
	
	fprintf(arquivo,"\ngetstatic java/lang/System/out Ljava/io/PrintStream;\n");
	fprintf(arquivo, "ldc \"%s\"\n");
	fprintf(arquivo, "invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V\n");
	fprintf(arquivo, "return\n");
    fclose(arquivo);
}

void istore(list *list,char *var){
	FILE *arquivo;
 	if ((arquivo=fopen("output.j","a"))==NULL){
 		return;
 	}
 	else{
 		int y = getIdVar(list,var);
 		fprintf(arquivo,"\nistore %d",y);
 		fclose(arquivo);
 	}
}

void ldc(int valor){
	FILE *arquivo;
 	if ((arquivo=fopen("output.j","a"))==NULL){
 		return;
 	}
 	else{
 		fprintf(arquivo,"\nldc %d",valor);
 		fclose(arquivo);
 	}

}

void iadd(){
	FILE *arquivo;
     if ((arquivo=fopen("output.j","a"))==NULL){
         return;
     }
     else{
         fprintf(arquivo,"\niadd");
         fclose(arquivo);
     }
}

void isub(){
	FILE *arquivo;
     if ((arquivo=fopen("output.j","a"))==NULL){
         return;
     }
     else{
         fprintf(arquivo,"\nisub");
         fclose(arquivo);
     }
}

void imul(){
	FILE *arquivo;
     if ((arquivo=fopen("output.j","a"))==NULL){
         return;
     }
     else{
         fprintf(arquivo,"\nimul");
         fclose(arquivo);
     }
}

void idiv(){
	FILE *arquivo;
     if ((arquivo=fopen("output.j","a"))==NULL){
         return;
     }
     else{
         fprintf(arquivo,"\nidiv");
         fclose(arquivo);
     }
}


void fmul(){
	FILE *arquivo;
     if ((arquivo=fopen("output.j","a"))==NULL){
         return;
     }
     else{
         fprintf(arquivo,"\nfmul");
         fclose(arquivo);
     }
}

