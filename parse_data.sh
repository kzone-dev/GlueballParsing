#!/bin/bash
#FILES=$(ls -dv /users/nrebelobrito/theta-dependence/torelons_measurements SU3_Lx12_Ly20_Lz20_Lt24_b6.0625/data/run-*/out_0)

# Usage: parse_data.sh <raw_logs_dir> <output_dir> <ensemble_name> <rpc_str>
RAWLOGS_PATH=$1
OUTPUT_DIR=$2
ENSEMBLE_NAME=$3
RPC_STR=$4

echo "Glueball raw data path:" $RAWLOGS_PATH
echo "Output dir:" $OUTPUT_DIR
echo "Ensemble name:" $ENSEMBLE_NAME
echo "RPC string:" $RPC_STR

JOINED_OUTPUT=$OUTPUT_DIR/${ENSEMBLE_NAME}_${RPC_STR}_result_joined.out
OUTPUT=$OUTPUT_DIR/${ENSEMBLE_NAME}_${RPC_STR}_result.out

mkdir -p $OUTPUT_DIR
rm -f $JOINED_OUTPUT $OUTPUT

FILES=$(ls -dv $RAWLOGS_PATH/$ENSEMBLE_NAME/data/run-*/out_0)
for conf_data in $FILES
do
    cat $conf_data >> $JOINED_OUTPUT
done

grep "$RPC_STR" $JOINED_OUTPUT >> $OUTPUT
rm $JOINED_OUTPUT
