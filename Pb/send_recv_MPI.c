#include <stdio.h>
#include <string.h>
#include <mpi.h>

int main(int argc, char **argv)
{
	int rank, size;
	MPI_Init(NULL, NULL);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	MPI_Comm_size(MPI_COMM_WORLD, &size);
	
	char message[100];
	if (rank == 0)
	{
		for(int source = 1; source < size; source++)
		{
			MPI_Recv(message, 100, MPI_CHAR, source, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
			printf("Process %d received: \"%s\"\n", rank, message);
		}
	}
	else
	{
		sprintf(message, "Hello I am process %d and I love u UwU",rank);
		MPI_Send(message, strlen(message) + 1, MPI_CHAR, 0, 0, MPI_COMM_WORLD);
	}
	
	MPI_Finalize();
	return 0;
}
