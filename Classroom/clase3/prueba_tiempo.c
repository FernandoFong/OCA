#include <time.h>
#include <stdio.h>
#include <pthread.h>

#define NUM_THREADS 50
unsigned long var_global = 0;

void *imprimeSuma()
{
  while(var_global < 1000000000){    
    var_global++;
  }
  pthread_exit(NULL);
}


int main(void)
{
  time_t start, end;
  double cpu_time_used;
  
  start = time(0);
  pthread_t threads[NUM_THREADS];
  int exito;
  int i;
  for(i = 0; i < NUM_THREADS; i++)
    {
      exito = pthread_create(&threads[i], NULL, imprimeSuma, NULL);
      if(exito)
	{
	  printf("ERROR al crear el thread %d. Linea: %d\n",i,__LINE__);
	}
    }
  for (int i = 0; i < NUM_THREADS; i++)
    pthread_join(threads[i], NULL);
  end = time(0);
  cpu_time_used = ((double) (end - start));
  printf("TIEMPO TOTAL: %f segundos. \n",cpu_time_used);
  return 0;
}
