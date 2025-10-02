#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <sys/time.h> // for gettimeofday()

#define N 64  // size of the vector

int main(int argc, char** argv) {
    int rank, size, i;
    struct timeval start, end;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    int local_n = N / size; // assume N divisible by number of processes

    int* full_vector = NULL;
    int* local_vector = malloc(local_n * sizeof(int));
    int* result_vector = NULL;

    if (rank == 0) {
        full_vector = malloc(N * sizeof(int));
        result_vector = malloc(N * sizeof(int));
        for (i = 0; i < N; i++) {
            full_vector[i] = i + 1; // example: [1, 2, 3, ..., N]
        }
        printf("Root process: initial vector = ");
        for (i = 0; i < N; i++) printf("%d ", full_vector[i]);
        printf("\n");
    }

    // Start timing
    MPI_Barrier(MPI_COMM_WORLD); // ensure all processes start together
    gettimeofday(&start, NULL);

    // Distribute the vector among processes
    MPI_Scatter(full_vector, local_n, MPI_INT,
                local_vector, local_n, MPI_INT,
                0, MPI_COMM_WORLD);

    //printf("Process %d received elements:", rank);
    for (i = 0; i < local_n; i++) printf(" %d", local_vector[i]);
    printf("\n");

    // Local computation: add 1 to each element
    for (i = 0; i < local_n; i++) {
        local_vector[i] += 1;
    }

    // Gather results to root process
    MPI_Gather(local_vector, local_n, MPI_INT,
               result_vector, local_n, MPI_INT,
               0, MPI_COMM_WORLD);

    // Stop timing
    MPI_Barrier(MPI_COMM_WORLD);
    gettimeofday(&end, NULL);

    if (rank == 0) {
        printf("Root process: gathered result = ");
        for (i = 0; i < N; i++) printf("%d ", result_vector[i]);
        printf("\n");

        double elapsed = (end.tv_sec - start.tv_sec) * 1000.0 +
                         (end.tv_usec - start.tv_usec) / 1000.0;
        printf("Parallel execution time: %.2f ms\n", elapsed);
    }

    // Cleanup
    if (rank == 0) {
        free(full_vector);
        free(result_vector);
    }
    free(local_vector);

    MPI_Finalize();
    return 0;
}
