#include  <stdio.h>
#include  <stdlib.h>
#include <time.h>
extern  int initarr(int** arr, int n, int (*initfunc)(int));

int getNum(int idx)
{
	return (2 * idx);
}

int main()

{
	int* arr, i, n, success;
	srand(time(NULL));
	printf("\nPlease enter the array size\n");
	scanf("%d", &n);
	success = initarr(&arr, n, getNum);
	if (!success)
	{
		printf("Memory Allocation Failed\n");
		return 0;
	}
	printf("\nThe Numbers in the allocated array are:\n");
	for (i = 0; i < n; i++)
		printf("%d  ", arr[i]);
	free(arr);
	return 0;
}



