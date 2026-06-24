#!/bin/bash

RAWLOGS_PATH=$1
OUTPUT_DIR=$2
ENSEMBLE_NAME=$3
RPC_STR=$4

echo "Glueball raw data path:" $1
echo "Output dir:" $2
echo "Ensemble name:" $3

grep "$RPC_STR" $RAWLOGS_PATH >> ${ENSEMBLE_NAME}_${RPC_STR}_result.out

mv ${ENSEMBLE_NAME}_${RPC_STR}_result.out $OUTPUT_DIR
