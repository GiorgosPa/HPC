#!/bin/sh
### General options
### –- specify queue --
#BSUB -q hpc
### -- set the job Name --
#BSUB -J My_Application
### -- ask for number of cores (default: 1) --
#BSUB -n 16
### -- set walltime limit: hh:mm --
#BSUB -W 1:00
### -- set the email address --
# please uncomment the following line and put in your e-mail address,
# if you want to receive e-mail notifications on a non-default address
##BSUB -u your_email_address
### -- send notification at start --
#BSUB -B
### -- send notification at completion --
#BSUB -N
### -- Specify the output and error file. %J is the job-id --
### -- -o and -e mean append, -oo and -eo mean overwrite --
#BSUB -o Output_%J.out
#BSUB -e Error_%J.err
#BSUB -R "select[model=XeonE5_2660v3]"

# here follow the commands you want to execute

module load cuda/8.0

cd /zhome/79/6/104772/Documents/HPC/week3/Assignment3


MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 10 10 10
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 25 25 25
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 75 75 75
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 100 100 100
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 250 250 250
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 500 500 500
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 750 750 750
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 1000 1000 1000
MATMULT_COMPARE=0 MFLOPS_MAX_IT=1 ./matmult_f.nvcc2 lib 2000 2000 2000