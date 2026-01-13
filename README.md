# Glueball Parsing from HiRep

Still very primitive, but simple.

1. Define the variable $DATA_DIRS in `parse_data.sh` so that it will contain an array with all log files from HiRep (from the repo at https://github.com/kzone-dev/hirep_glueballs);
2. Run the shell script `parse_data.sh`
3. Set the `input_dir` and `output_dir` variables in `convert_to_hdf5.py`
4. Run the python script `convert_to_hdf5.py`

# Output:

A file per ensemble named `ensemble_results.h5`.

    - There will be keys such as "A1pp -> A1++" or "A1mp -> A1-+" referring to the channel. 
    - Inside each there will be keys containing the interpolating operators, the vev and other relevant parameters.

