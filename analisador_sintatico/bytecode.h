#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"

list *l;

list *lw;

int contIF;

void header()
{
	l = list_create();

	FILE *arquivo;
	if ((arquivo = fopen("output.j", "w")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, ".class public Teste\n.super java/lang/Object\n\n");
		fprintf(arquivo, ".method public <init>()V\naload_0\ninvokenonvirtual java/lang/Object/<init>()V\nreturn\n.end method\n\n");
		fprintf(arquivo, ".method public static main([Ljava/lang/String;)V\n.limit stack 100\n.limit locals 100\n");
		fclose(arquivo);
	}
}

void final()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nreturn\n.end method");
		fclose(arquivo);
	}
}

void print(char *saida)
{
	FILE *arquivo;

	fprintf(arquivo, "\ngetstatic java/lang/System/out Ljava/io/PrintStream;\n");
	fprintf(arquivo, "ldc \"%s\"\n", saida);
	fprintf(arquivo, "invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V\n");
	fprintf(arquivo, "return\n");
	fclose(arquivo);
}

void istore(list *list, char *var)
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		printf("%s", var);
		int y = getIdVar(list, var);
		fprintf(arquivo, "\nistore %d", y);
		fclose(arquivo);
	}
}

void atribV(list *list, char *var1, char *var2)
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		int x = getIdVar(list, var2);
		int y = getIdVar(list, var1);
		fprintf(arquivo, "\niload %d\nistore %d", x, y);
		fclose(arquivo);
	}
}

void iload(list *list, char *var)
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		int y = getIdVar(list, var);
		fprintf(arquivo, "\niload %d", y);
		fclose(arquivo);
	}
}

void bipush(int x)
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\nbipush %d", x);
		fclose(arquivo);
	}
}

void ldcf(float x)
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nldc %f", x);
		fclose(arquivo);
	}
}

void iadd()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niadd");
		fclose(arquivo);
	}
}

void isub()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nisub");
		fclose(arquivo);
	}
}

void imul()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nimul");
		fclose(arquivo);
	}
}

void idiv()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nidiv");
		fclose(arquivo);
	}
}

void fmul()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nfmul");
		fclose(arquivo);
	}
}

void fadd()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nfadd");
		fclose(arquivo);
	}
}

void fsub()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nfsub");
		fclose(arquivo);
	}
}

void fdiv()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nidiv");
		fclose(arquivo);
	}
}

void plusplus(list *list, char *var)
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niinc %d %d", getIdVar(list, var), 1);
		fclose(arquivo);
	}
}

void ifeqi(list *v, char *var, int x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpeq l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifnei(list *v, char *var, int x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpne l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifiti(list *v, char *var, int x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpit l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifiei(list *v, char *var, int x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpie l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifgti(list *v, char *var, int x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpgt l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifgei(list *v, char *var, int x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpge l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}
//======================================================IFF
void ifeqf(list *v, char *var, float x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpeq l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifnef(list *v, char *var, float x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpne l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifitf(list *v, char *var, float x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpit l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifief(list *v, char *var, float x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpie l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifgtf(list *v, char *var, float x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpgt l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifgef(list *v, char *var, float x)
{
	FILE *arquivo;
	int y = getIdVar(v, var);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpge l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}
//======================================================IFV
void ifeqv(list *v, char *var1, char *var2)
{
	FILE *arquivo;
	int x = getIdVar(v, var1);
	int y = getIdVar(v, var2);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niload %d", x);
		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpeq l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifnev(list *v, char *var1, char *var2)
{
	FILE *arquivo;
	int x = getIdVar(v, var1);
	int y = getIdVar(v, var2);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niload %d", x);
		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpne l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifitv(list *v, char *var1, char *var2)
{
	FILE *arquivo;
	int x = getIdVar(v, var1);
	int y = getIdVar(v, var2);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niload %d", x);
		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpit l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifiev(list *v, char *var1, char *var2)
{
	FILE *arquivo;
	int x = getIdVar(v, var1);
	int y = getIdVar(v, var2);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niload %d", x);
		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpie l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifgtv(list *v, char *var1, char *var2)
{
	FILE *arquivo;
	int x = getIdVar(v, var1);
	int y = getIdVar(v, var2);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niload %d", x);
		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpgt l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void ifgev(list *v, char *var1, char *var2)
{
	FILE *arquivo;
	int x = getIdVar(v, var1);
	int y = getIdVar(v, var2);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\niload %d", x);
		fprintf(arquivo, "\niload %d", y);
		fprintf(arquivo, "\nif_icmpge l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void printLabel()
{
	FILE *arquivo;
	int label = list_pop_backp(l);
	;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{

		fprintf(arquivo, "\nl%d:", label);
		fclose(arquivo);
	}
}

void printLabelInvertido()
{
	FILE *arquivo;
	int label = list_pop_backpA(l);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nl%d:", label);
		fclose(arquivo);
	}
}

void gotol()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\ngoto l%d", contIF);
		fclose(arquivo);
	}
	list_push_backp(l, contIF);
	contIF++;
}

void printLabelWhile()
{
	FILE *arquivo;
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\nl%d:", contIF);
		fclose(arquivo);
	}
	list_push_backp(lw, contIF);
	contIF++;
}

void gotolW()
{
	FILE *arquivo;
	int label = list_pop_backp(lw);
	if ((arquivo = fopen("output.j", "a")) == NULL)
	{
		return;
	}
	else
	{
		fprintf(arquivo, "\ngoto l%d", label);
		fclose(arquivo);
	}
}
