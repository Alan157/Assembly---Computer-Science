#include <stdio.h>
extern double expPowM2x(long(*pf)(int n), double x, int n);
extern double expPowM2xEps(long(*pf)(int n), double x, double eps);
long f(int n)
{
	if (n == 0)
		return 1;
	return 2 * f(n - 1);
}
int  main()
{
	int n = 20;
	double eps = 0.0001, x = 0.623599, res;
	res = expPowM2x(f, x, n);
	printf("expPowM2x(f,x,n)= expPowM2x (f,%lf,%d) = %lf\n", x, n, res);
	res = expPowM2xEps(f, x, eps);
	printf("\nexpPowM2xEps (f,x, eps)= expPowM2xEps (f,%lf,%lf) = %lf", x, eps, res);
	return 0;
}
