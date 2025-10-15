#!/bin/bash
#SBATCH -J matrix_mult
#SBATCH -t 00:15
#SBATCH -o %x_%J.out
#SBATCH -e %xo_%J.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --exclusive
#SBATCH --account nct_345
#SBATCH --qos gp_debug

module load cuda

echo "[ nvcc matrix_mult_CUDA.cu -o m_CUDA ]"
nvcc matrix_mult_CUDA.cu -o m_CUDA

echo "[ ./m_CUDA ]"
./m_CUDA
