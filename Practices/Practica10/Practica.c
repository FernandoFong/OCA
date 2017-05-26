
void inst_fetch(void)
{
  int i = program_counter;
  for(i; i < program_counter+32; i++) {
    ir[i] = memoria[i];
  }
}

void decode(void)
{
  /* Identificamos el tipo de instruccion */
  /* enviamos señales de la unidad de control dependiendo de la instr.*/
  
}

void int_fetch(void);

char memoria[1024*16*8];

int program_counter = 0; //La primer dirección de memoria.

char IR[32];

typedef struct UC {

  char reg_write;
  char ALUSrc1;
  char ALUSrc2;
  /*
    .
    .
    .
  */
}UC;

typedef struct reg_file {
  char read_reg_A[6];
  char read_reg_B[6];
  char write_reg[6];
  char write_data[32];
  char registers[32][32];
}RF;
char ext_sgn[16];
