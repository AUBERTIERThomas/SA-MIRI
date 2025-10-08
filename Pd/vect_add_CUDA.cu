// add_CUDA.cu
#include <cuda_runtime.h>
#include <stdio.h>

#define N 4194304
#define TPB 

__global__ void add(int *a, int *b, int *c)
{
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	if(index < n) c[index] = a[index] + b[index];
}

int main(void)
{
	int *a,*b,*c;
	int *d_a,*d_b,*d_c;
	int size = N*sizeof(int);
	
	cudaMalloc((void **)&d_a, size);
	cudaMalloc((void **)&d_b, size);
	cudaMalloc((void **)&d_c, size);
	
	a = (int*)malloc(size); random_ints(a,N);
	b = (int*)malloc(size); random_ints(b,N);
	c = (int*)malloc(size);
	
	cudaMemcpy(d_a, &a, size, cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, &b, size, cudaMemcpyHostToDevice);
	
	add<<<N/TPB,TPB>>>(d_a,d_b,d_c);
	
	cudaMemcpy(d_c, &c, size, cudaMemcpyDeviceToHost);
	
	free(a);
	free(b);
	free(c);
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);
	
	return 0;
}
