#include <stdlib.h>
#include "list.h"
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

int var_count = 0;

typedef struct item {
  char *nome;
  int linha;
  char *tipo;
  bool isvar;
  int id;

  struct item *next;
  struct item *prev;
} item;

struct list {
  item *head;
  item *tail;
};

list *list_create(void) {
  list *result = malloc(sizeof(list));

  result->head = NULL;
  result->tail = NULL;

  return result;
}

static void item_delete(item *item) {
  if(item) {
    item_delete(item->next);
    free(item);
  }
}

void list_delete(list *list) {
  item_delete(list->head);
  free(list);
}

void list_push_back(list *list, char *nome, int linha, char *tipo, bool isvar) {
  item *obj = malloc(sizeof(item));

  obj->next = NULL;
  obj->prev = list->tail;
  obj->nome = (char*)malloc(sizeof(char*)*strlen(nome));
  strcpy(obj->nome,nome);
  obj->linha = linha;
  obj->tipo = (char*)malloc(sizeof(char*)*strlen(tipo));
  strcpy(obj->tipo,tipo);
  obj->isvar = isvar;

  if(list->tail) {
    list->tail->next = obj;
    list->tail = obj;
  } else {
    list->head = obj;
    list->tail = obj;
  }

  if(isvar == true){
    obj->id == var_count;
    var_count++;
  }
}

char* list_pop_back(list *list) {
  if(list->tail) {
    item *item = list->tail;
    char *result = item->nome;

    if(list->head == list->tail) {
      list->head = NULL;
      list->tail = NULL;
    } else {
      list->tail = item->prev;
      item->prev->next = NULL;
    }
    free(item->nome);
    free(item);

    return result;
  }

  return 0;
}

int list_size(list *list) {
  int count = 0;
  for(item *i = list->head; i != NULL; i = i->next) {
    count++;
  }

  return count;
}

void list_show(list *list) {
	for(item *i = list->head; i != NULL; i = i ->next) {
		printf("Token: %s (linha = %d)\n", i->nome, i->linha);
	}
}

void setTipo(list *list,char *tipo,char *var){
	for(item *i = list->tail; i!= NULL; i = i->prev){
		if(strcmp(var,i->nome)==0){
      			strcpy(i->tipo,tipo);
    		}
	}
}

int getIdVar(list *list,char *var){
	for(item *i = list->head; i!= NULL; i = i->next){
		if(strcmp(i->nome,var)==0){
      			return i->id;
    		}
	}
	return -1;
}