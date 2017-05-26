#include <stdio.h>

void swap(int *a, int *b);

int main()
{
  int a= 3, b = 4;
  swap(&a, &b);
  printf("a = %d, b = %d", a, b);
  return 0;
}

void swap(int *a, int *b)
{
  int aux = *a;
  *a = *b;
  *b = aux;
}
