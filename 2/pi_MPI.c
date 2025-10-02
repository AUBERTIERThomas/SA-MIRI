#include <stdio.h>
#include <mpi.h>

#define N 100000000  // Total number of trapezoids

double f(double x)
{
    return 4.0 / (1.0 + x * x);
}

double trap_rule(double a, double b, int n)
{
    double h = (b - a) / n;
    double sum = (f(a) + f(b)) / 2.0;

    for (int i = 1; i < n; i++)
        sum += f(a + i * h);

    return sum * h;
}

int main(int argc, char **argv)
{
    int rank, size;
    double local_a, local_b, local_integral;
    int local_n;

    double a = 0.0, b = 1.0;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    double h = (b - a) / N;
    local_n = N / size;
    local_a = a + rank * local_n * h;
    local_b = local_a + local_n * h;

    local_integral = trap_rule(local_a, local_b, local_n);

    double total_integral;
    MPI_Reduce(&local_integral, &total_integral, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        printf("Estimated value of pi = %.15f\n", total_integral);
    }

    MPI_Finalize();
    return 0;
}
