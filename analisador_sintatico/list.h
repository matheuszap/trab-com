#include <stdlib.h>

typedef struct list list;

list *list_create(void);

void list_delete(list *);

void list_push_back(list *list, char *nome, int linha);

char *list_pop_back(list *list);

int list_size(list *);

void list_show(list *list);