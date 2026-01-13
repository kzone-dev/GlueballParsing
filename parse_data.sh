#!/bin/bash

# M3 ensemble
M3_DATA_DIRS=$(ls -dv users/nrebelobrito/raw_glueball_data/M3/glueballs/run-*/out_0)

for dir in $DATA_DIRS
do
	grep "A1pp" $dir >> M3_A1pp_result.out
	grep "A1mp" $dir >> M3_A1mp_result.out
done

#M4 ensemble
M4_DATA_DIRS=$(ls -dv users/nrebelobrito/raw_glueball_data/M4/glueballs/run-*/out_0)

for dir in $DATA_DIRS
do
	grep "A1pp" $dir >> M4_A1pp_result.out
	grep "A1mp" $dir >> M4_A1mp_result.out
done

OUTPUT_DIR=users/nrebelobrito/flavour_singlet_and_glueball_mixing_sp4/data/parsed_glueball_data/

mv *.out $OUTPUT_DIR 

