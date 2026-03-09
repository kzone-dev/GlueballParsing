#!/bin/bash

RAWLOGS_DIR=$1
OUTPUT_DIR=$2
ENSEMBLE_NAME=$3
RPC_STR=$4

DATA_DIRS=$(ls -dv $RAWLOGS_DIR/run-*/out_0)

echo "Glueball raw data DIR:" $1
echo "Output dir:" $2
echo "Ensemble name:" $3

for dir in $DATA_DIRS
do
    grep "$RPC_STR" $dir >> ${ENSEMBLE_NAME}_${RPC_STR}_result.out
done

mv ${ENSEMBLE_NAME}_${RPC_STR}_result.out $OUTPUT_DIR
