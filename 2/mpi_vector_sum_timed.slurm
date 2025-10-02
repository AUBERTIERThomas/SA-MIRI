#!/bin/bash
#SBATCH --job-name=pi_scaling
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --ntasks=64     
#SBATCH --cpus-per-task=1
#SBATCH --time=00:15:00
#SBATCH --exclusive
#SBATCH --account=nct_345
#SBATCH --qos=gp_debug

module load oneapi/2023.2.0

echo "=== COMPILING ==="
mpiicx -O3 mpi_vector_sum_timed.c -o mpi_vector_sum_timed

echo "=== RUNNING SEQUENTIAL ==="
./pi_seq_timed


for P in 1 2 4 8 16 32
do
  echo ""
  echo "=== RUNNING WITH $P PROCESSES ==="
  srun --ntasks=$P ./mpi_vector_sum_timed
done