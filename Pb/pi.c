#include <stdio.h>
#include <sys/time.h>

#define N 1000000

struct timeval s_time, e_time;

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
	gettimeofday(&s_time, NULL);

	double a = 0.0, b = 1.0;
	double pi = trap_rule(a,b,N);
	printf("Estimated PI = %.16f\n", pi);
	
	gettimeofday(&e_time, NULL);
	
	int ttime = (e_time.tv_sec - s_time.tv_sec) * 1000000 + (e_time.tv_usec - s_time.tv_usec);
	printf("It took %.6f s !\n", (float)ttime/1000000.0);
	
	return 0;
}
