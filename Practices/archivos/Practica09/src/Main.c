#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "Queue.h"
#define true 1
#define false 0

/**
 *Función que nos regresa un apuntador a caracter correspondiente a otro
 *apuntador a caracter, regresa la subcadena desde ini hasta fin.
 *@param char *str, cadena original, un entero que marca el inicio del substring,
 *otro entero que marca el final del substring.
 *@return un apuntador a caracter correspondiente al substring.
 */
char *substr(char *str, int ini, int fin);

int valido(char c);

char *valid_lexema(char *lexema);

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
  QUEUE *labels = new_queue();
  char *prev = dequeue(queue), *curr;
  while(size(queue) > 0) {
    printf("%s\n", prev);
    curr = dequeue(queue);
    if(strcmp(":", curr) == 0)
      enqueue(labels, prev);
    prev = curr;
  }
  printf("%s\n", curr);
  while(size(labels) > 0) {
    label_counter += 4;
    char *label_out = dequeue(labels);
    printf("%s %i\n", label_out, &(label_out)+label_counter);
  }
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
