#include <string.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct estudiante {
  char *nombre;
  char *apellido;
  long int cuenta;
  double promedio;
  int edad;
}ESTUDIANTE;

ESTUDIANTE* init_estud(char *nombre, char *apellido, long int cuen,
		       double prom, int ed)
{
  char *nombre_final = malloc(sizeof(char)*strlen(nombre));
  strcpy(nombre_final, nombre);
  char *apellido_final = malloc(sizeof(char)*strlen(apellido));
  strcpy(apellido_final, apellido);
  ESTUDIANTE *alumno = malloc(sizeof(ESTUDIANTE));
  alumno -> cuenta = cuen;
  alumno -> promedio = prom;
  alumno -> edad = ed;
  alumno -> nombre = nombre_final;
  alumno -> apellido = apellido_final;
  return alumno;
}

void imprime_estudiante(ESTUDIANTE *e)
{
  printf("%s\n%s\n%li\n%f\n%d\n", e->nombre, e->apellido, e->cuenta,
	 e->promedio, e->edad);
}

int main() {
  ESTUDIANTE *fer = init_estud("Fernanda", "Gonzalez", 313036367,
			       8.9, 19);
  ESTUDIANTE *fong = init_estud("Fernando", "Fong", 313320679,
				8.4, 19);
  imprime_estudiante(fer);
  imprime_estudiante(fong);
  return 0;
}
