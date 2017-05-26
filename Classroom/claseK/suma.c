#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv [])
{
  int entrada, argumento;
  scanf("%d", &entrada);
  printf("La variable es %d\n", entrada);
  char *tmp = argv[1];
  argumento = atoi(tmp);
  printf("La suma es: %d\n", argumento+entrada);
  return 0;
}
