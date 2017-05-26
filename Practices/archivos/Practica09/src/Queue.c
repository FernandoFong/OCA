#include <stdlib.h>
#include "Queue.h"

typedef struct node{
  void *elem;
  struct node *next;
}NODE;

struct queue {
  NODE *head;
  NODE *tail;
  int size;
};

QUEUE *new_queue()
{
  QUEUE *ptnew_q = malloc(sizeof(QUEUE));
  ptnew_q -> head = NULL;
  ptnew_q -> tail = NULL;
  ptnew_q -> size = 0;
  return ptnew_q;
}

int size(QUEUE *queue)
{
  return queue -> size;
}

void enqueue(QUEUE *queue, void *elem)
{
  NODE *ptnew_n = malloc(sizeof(NODE));
  ptnew_n -> elem = elem;
  ptnew_n -> next = NULL;
  if(size(queue) == 0) {
    queue -> head = ptnew_n;
  }else {
    queue -> tail -> next = ptnew_n;
  }
  queue -> tail = ptnew_n;
  queue -> size++;
}

void *dequeue(QUEUE *queue)
{
  if(size(queue) == 0)
    return NULL;
  void *aux = queue -> head -> elem;
  NODE *head = queue -> head;
  queue -> head = queue -> head -> next;
  free(head);
  if(size(queue) == 1)
    queue -> tail = NULL;
  queue -> size--;
  return aux;
}

void free_queue(QUEUE *queue)
{
  while(size(queue) > 0) {
    dequeue(queue);
  }
  free(queue);
}
