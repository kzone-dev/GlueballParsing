#!/bin/bash

# M3 ensemble
M3_RAWLOGS_DIR=$1
M4_RAWLOGS_DIR=$2
OUTPUT_DIR=$3

M3_DATA_DIRS=$(ls -dv $M3_RAWLOGS_DIR/run-*/out_0)

for dir in $M3_DATA_DIRS
do
	grep "A1pp" $dir >> M3_A1pp_result.out
	grep "A1mp" $dir >> M3_A1mp_result.out
done

#M4 ensemble
M4_DATA_DIRS=$(ls -dv $M4_RAWLOGS_DIR/run-*/out_0)

for dir in $M4_DATA_DIRS
do
	grep "A1pp" $dir >> M4_A1pp_result.out
	grep "A1mp" $dir >> M4_A1mp_result.out
done

mv *.out $OUTPUT_DIR 