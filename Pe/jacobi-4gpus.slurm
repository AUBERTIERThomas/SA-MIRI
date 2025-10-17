#!/bin/bash
#SBATCH --job-name=jacobi-4gpus
#SBATCH -o %x_%J.out
#SBATCH -e %x_%J.err

#SBATCH --nodes=1
#SBATCH --time=02:00:00
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --exclusive

#SBATCH --account=nct_345
#SBATCH --qos=acc_debug

#module load oneapi/2023.2.0
module load nvidia-hpc-sdk/23.11-cuda11.8

make clean
#make default
#make optimized
make cub

for i in 8 16 32; do
  for j in 8192 16384 32768; do
	mpirun -np $i ./jacobi -niter 100000 -nx $j -ny $j
  done
done
