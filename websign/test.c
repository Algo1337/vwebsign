#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <Net/web.h>

typedef void *voidptr;

Control **convert(void **arr, int n) {
    arr[n] = NULL;
    return (Control **)arr;
}


CSS **convert_css(void **arr, int n) {
    arr[n] = NULL;
    return (CSS **)arr;
}
