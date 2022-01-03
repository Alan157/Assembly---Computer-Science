#include <stdio.h>
extern int  PermutationArray(int arr1[], int arr2[], int size);

int main()
{
	int arr1[] = { 1,4,7,9,9,0 };
	int arr2[] = { 9,0,7,1,9,4 };
	int arr3[] = { 1,4,4,9,7,0 };

	if (PermutationArray(arr1, arr3, 6) == 1)
		printf("\narr1 permutation of arr2 \n");
	else
		printf("\narr1 is not permutation of arr2 \n");

	if (PermutationArray(arr1, arr2, 6) == 1)
		printf("\narr1 permutation of arr3 \n");
	else
		printf("\narr1 is not permutation of arr3 \n");

	return 0;
}
