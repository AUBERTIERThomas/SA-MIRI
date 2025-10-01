#!/bin/bash
#SBATCH -J pi_mpi
#SBATCH -t 00:05
#SBATCH -o %x_%J.out
#SBATCH -e %xo_%J.err
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --exclusive
#SBATCH --account nct_345
#SBATCH --qos gp_debug

srun ./pi_MPI
