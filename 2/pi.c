#include <stdio.h>

#define N 1000000

double f(double x)
{
	return 4.0 / (1.0 + x*x);
}

double trap_rule(double a, double b, int n)
{
	double h = (b-a)/n;
	double sum = (f(a) + f(b))/2.0;
	
	for(int i = 1; i < n; i++)
		sum += f(a+i*h);
	
	return sum*h;
}

int main(int argc, char **argv)
{
	double a = 0.0, b = 1.0;
	double pi = trap_rule(a,b,N);
	printf("Estimated PI = %.16f\n", pi);
	return 0;
}
