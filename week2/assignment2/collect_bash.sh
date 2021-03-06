#!/bin/bash
# 02614 - High-Performance Computing, January 2017
# 
# batch script to run collect on a decidated server in the hpcintro
# queue
#
# Author: Bernd Dammann <bd@cc.dtu.dk>
#
#PBS -N collector
#PBS -q hpcintro
#PBS -l nodes=1:ppn=20
#PBS -l walltime=10:00
#PBS -M s161601@student.dtu.dk
#PBS -M s151138@student.dtu.dk
#PBS -m abe

cd $PBS_O_WORKDIR

module load studio


EXECUTABLE=driver

# experiment name 
#
JID=`echo ${PBS_JOBID%.*}`
EXPOUT="$PBS_JOBNAME.${JID}.er"

# uncomment the HWCOUNT line, if you want to use hardware counters
# define an option string for the harwdware counters (see output of
# 'collect -h' for valid values.  The format is:
# -h cnt1,on,cnt2,on,...  (up to four counters at a time)
#
# the example below is for L1 hits, L1 misses, L2 hits, L2 misses
#
#HWCOUNT="-h dch,on,dcm,on,l2h,on,l2m,on"
export OMP_NUM_THREADS=16
export OMP_WAIT_POLICY=active

# start the collect command with the above settings
./$EXECUTABLE jacomp 10 1000 50000
./$EXECUTABLE jacomp 20 1000 4000
./$EXECUTABLE jacomp 40 1000 800
./$EXECUTABLE jacomp 80 1000 200
./$EXECUTABLE jacomp 160 1000 50
./$EXECUTABLE jacomp 320 1000 10
./$EXECUTABLE jacomp 640 1000 1
./$EXECUTABLE jacomp 1280 1000 1
./$EXECUTABLE jacomp 2000 1000 1
./$EXECUTABLE jacomp 2600 1000 1

# ./$EXECUTABLE jacomp 100 1000 10

# ./$EXECUTABLE gauss 100 1000 10

# ./$EXECUTABLE jac 100 1000 10

# ./$EXECUTABLE jacomp 100 1000 10

# ./$EXECUTABLE gauss 100 1000 10
# collect -r on ./$EXECUTABLE jacomp 100 1000 10
# collect -o $EXPOUT ./$EXECUTABLE jacomp 100 1000 10
# collect -r on ./$EXECUTABLE jacompdatarace 100 1000 10
