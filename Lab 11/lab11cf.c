#include <stdio.h>
#define N 10
extern float avg_pows(float[], int size);
int main()
{
	float arr[N];
	int i;
	printf("\nPlease Enter %d real numbers\n", N);
	for (i = 0; i < N; i++)
		scanf("%f", &arr[i]);
	printf("\nThe result is %f\n", avg_pows(arr, N));
	return 0;
}



