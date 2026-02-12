#!/bin/bash

RAWLOGS_DIR=$1
OUTPUT_DIR=$2
ENSEMBLE_NAME=$3

DATA_DIRS=$(ls -dv $RAWLOGS_DIR/run-*/out_0)

echo "Glueball raw data DIR:" $1
echo "Output dir:" $2
echo "Ensemble name:" $3

for dir in $DATA_DIRS
do
    grep "A1pp" $dir >> ${ENSEMBLE_NAME}_A1pp_result.out
	grep "A1mp" $dir >> ${ENSEMBLE_NAME}_A1mp_result.out
done

mv ${ENSEMBLE_NAME}_A1pp_result.out ${ENSEMBLE_NAME}_A1mp_result.out $OUTPUT_DIR
