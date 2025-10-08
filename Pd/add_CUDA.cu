// add_CUDA.cu
#include <cuda_runtime.h>
#include <stdio.h>

#define T 4

__global__ void add(int *a, int *b, int *c)
{
	*c = *a + *b;
	printf("GPU : computed %d + %d = %d\n", *a, *b, *c);
}

int main(void)
{
	int a,b,c;
	int *d_a,*d_b,*d_c;
	int size = sizeof(int);
	
	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_c, size);
	
	a = 2;
	b = 7;
	
	cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);
	
	add<<<1,T>>>(d_a,d_b,d_c);
	
	cudaMemcpy(d_c, &c, size, cudaMemcpyDeviceToHost);
	
	printf("CPU : received %d + %d = %d\n", a, b, c);
	
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	cudaDeviceReset();
	
	return 0;
}
