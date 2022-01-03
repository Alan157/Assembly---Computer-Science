#include <stdio.h>
#define N 10
extern double avg_pows(double[], int size);
int main()
{
	double arr[N];
	int i;
	printf("\nPlease Enter %d real numbers\n", N);
	for (i = 0; i < N; i++)
		scanf("%lf", &arr[i]);
	printf("\nThe result is %lf\n", avg_pows(arr, N));
	return 0;
}



