#!/bin/bash
#SBATCH --job-name=cnn_train
#SBATCH -o %x_%J.out
#SBATCH -e %x_%J.err

#SBATCH --nodes=1
#SBATCH --time=00:15:00
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --exclusive

#SBATCH --account=nct_345
#SBATCH --qos=acc_debug

module purge
module load singularity

SINGULARITY_CONTAINER=/gpfs/scratch/nct01029/MN5-NGC-TensorFlow-23.03.sif

singularity exec $SINGULARITY_CONTAINER python cnn_train.py
