#!/bin/bash
# 02614 - High-Performance Computing, January 2017
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
# Note: to get more cores, change the ppn value below to the
#       number of cores you want to use.  Later on, use the
#       $PBS_NUM_PPN variable to use this number, e.g. in
#       export OMP_NUM_THREADS=$PBS_NUM_PPN
#
#PBS -N collector
#PBS -q hpcintro
#PBS -l nodes=1:ppn=20
#PBS -l walltime=10:00

cd $PBS_O_WORKDIR


# define the executable here
#

# define any command line options for your executable here
# EXECOPTS=

# set some OpenMP variables here
#
# no. of threads
export OMP_NUM_THREADS=1
#
# keep idle threads spinning (needed to monitor idle times!)
export OMP_WAIT_POLICY=active
#
# if you use a runtime schedule, define it below
# export OMP_SCHEDULE=


# experiment name 
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100


export OMP_NUM_THREADS=2
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=4
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=6
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=8
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=10
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=12
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=14
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=16
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=18
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100

export OMP_NUM_THREADS=20
./driver jacompsimple 160 1000 100
./driver jacomp 160 1000 100