/*
    define list data struct
 */
 #ifndef _LIST_H__
 #define _LIST_H__
 
 typedef struct list{
     list *prev;
     list *next;
 }list_t;
 
 #endif