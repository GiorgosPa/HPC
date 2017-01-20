#!/bin/sh
### General options
### –- specify queue --
#BSUB -q k40
### -- set the job Name --
#BSUB -J k40job
### -- ask for number of cores (default: 1) --
#BSUB -n 2
### -- Select the resources: 2 gpus in exclusive process mode --
#BSUB -R "rusage[ngpus_excl_p=1]"
### -- set walltime limit: hh:mm --
#BSUB -W 00:30
### -- set the email address --
# please uncomment the following line and put in your e-mail address,
# if you want to receive e-mail notifications on a non-default address
##BSUB -u your_email_address
### -- send notification at start --
#BSUB -B
### -- send notification at completion--
#BSUB -N
### -- Specify the output and error file. %J is the job-id --
### -- -o and -e mean append, -oo and -eo mean overwrite --
#BSUB -o gpu-%J.out
#BSUB -e gpu_%J.err

# -- end of LSF options --

# Load the cuda module
module load cuda/8.0

# * this program sees only the gpu's which are requested.
# * double check the number of your requested gpus above.
# * max-walltime in this queue is 30 minutes
# * this node has only 12 cores, so please don't request more
#   than 2 cpu-cores
#

cd /zhome/79/6/104772/Documents/HPC/week3/Assignment3


MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 10 10 10
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 32 32 32
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 64 64 64
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 128 128 128
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 256 256 256
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 512 512 512
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 768 768 768
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 1024 1024 1024
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 nvprof ./matmult_f.nvcc2 gpu5 2048 2048 2048
