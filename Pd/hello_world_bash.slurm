#!/bin/bash
#SBATCH -J mpi_helloworld
#SBATCH -t 00:15
#SBATCH -o %x_%J.out
#SBATCH -e %xo_%J.err
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --account nct_345
#SBATCH --qos gp_debug

module load oneapi/2023.2.0

echo "[ mpirun ./hello_world_MPI ]"
mpirun ./hello_world_MPI.c

echo "[ srun ./hello_world_MPI ]"
srun ./hello_world_MPI.c
