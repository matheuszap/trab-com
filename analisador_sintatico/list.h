#include <stdlib.h>
#include <stdbool.h>

typedef struct list list;

list *list_create(void);

void list_delete(list *);

void list_push_back(list *list, char *nome, int linha, char *tipo, bool isvar);

char *list_pop_back(list *list);

int list_size(list *);

void list_show(list *list);

int getIdVar(list *list, char *var);

void setTipo(list *list, char *tipo, char *var);

void setVali(list *list, int val, char *var);
void setValf(list *list, float val, char *var);
void setValv(list *list, char *var2, char *var1);

char *getValVar(list *list, char *var);

void list_push_backp(list *list, int id);
int list_pop_backp(list *list);
int list_pop_backpA(list *list);