#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Queue.h"
#define true 1
#define false 0

char *substr(char *str, int ini, int fin);

int valido(char c);

int valid_lexem(char *lexema);

void print_queue(QUEUE *queue);

char *concat(char *a, char *b);

char *binario(long int a);

int main(int argc, char * args[])
{
  int label_counter = 0;
  QUEUE *queue = new_queue();
  FILE *archivo = fopen(args[1], "r");
  if(archivo == NULL) {
      printf("%s\n", "Error al abrir el archivo");
      return -1;
  }
  char linea[1024];
  while(fgets(linea, 1024, archivo) != NULL) {
    int i, j;
    for(i = 0; i < strlen(linea); i++) {
      if(linea[i] == '.') {
  	enqueue(queue, ".");
      }else if(linea[i] == ',') {
  	enqueue(queue, ",");
      }else if(linea[i] == ':') {
  	enqueue(queue, ":");
      }else if(valido(linea[i])) {
  	for(j = i; valido(linea[j]); j++) {}
  	enqueue(queue, substr(linea, i, j));
  	i = j-1;
      }
    }
  }
  QUEUE *words = new_queue();
  while(size(queue) > 0) {
    char *aux = dequeue(queue);
    if(strcmp(aux,".") != 0 && strcmp(aux,",") != 0)
      enqueue(words, aux);
  }
  free_queue(queue);
  char *init = dequeue(words), *instr;
  int i;
  return fclose(archivo) != EOF;
}

char *substr(char *str, int ini, int fin)
{
  int size = fin - ini;
  char *substr = malloc(sizeof(char)*size);
  int i = ini, j = 0;
  while(i < fin)
    substr[j++] = str[i++];
  return substr;
}

int valido(char c)
{
  if(c > 32 && c != '.' && c != ',' && c != ':')
    return true;
  else
    return false;
}

int valid_lexem(char *lexem)
{
  if(strcmp(",", lexem) == 0)
    return false;
  else if(strcmp(".",lexem) == 0)
    return false;
  else if(strcmp(":", lexem) == 0)
    return false;
  return true;
}

void print_queue(QUEUE *queue)
{
  while(size(queue) > 0)
    printf("%s\n", dequeue(queue));
  free_queue(queue);
}

char *concat(char *a, char *b)
{
  int size = strlen(a)+strlen(b);
  char *v_return = calloc(size, sizeof(char));
  int i, a_length = strlen(a);
  for(i = 0; i < size; i++)
    {
      if(i < a_length)
	v_return[i] = a[i];
      else
	v_return[i] = b[i - a_length];
    }
  return v_return;
}

char *binario(long int a)
{
  if(a == 0)
    return "0";
  else if(a == 1)
    return "1";
  else if(a % 2 == 0)
    return concat(binario(a/2), "0");
  else
    return concat(binario(a/2), "1");
}
