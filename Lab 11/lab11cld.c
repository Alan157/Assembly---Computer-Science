#include <stdio.h>
#define N 10
extern long double avg_pows(long double[], int size);
int main()
{
	long double arr[N];
	int i;
	printf("\nPlease Enter %d real numbers\n", N);
	for (i = 0; i < N; i++)
		scanf("%Lf", &arr[i]);
	printf("\nThe result is %Lf\n", avg_pows(arr, N));
	return 0;
}



