#!/bin/bash

## SLURM JOB specifications
#SBATCH -t 00:10:00
#SBATCH --account=<account>
#SBATCH --qos=acc_debug

## SLURM JOB actions (actual job to execute)
echo "This is job $SLURM_JOBID \
on $(hostname) at $(date)"


