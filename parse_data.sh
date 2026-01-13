#!/bin/bash

DATA_DIRS=$(ls -dv ../glueballs/run-*/out_0)

rm A1mp_result.out A1pp_result.out

for dir in $DATA_DIRS
do
	grep "A1pp" $dir >> A1pp_result.out
	grep "A1mp" $dir >> A1mp_result.out
done

