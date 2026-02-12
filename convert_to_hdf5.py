import h5py
import numpy as np
import os
import argparse

def parse_args():
    parser = argparse.ArgumentParser(description='Convert glueball operator data from txt to HDF5 format.')
    parser.add_argument('--input_dir', type=str, required=True, help='Path to the input txt file.')
    parser.add_argument('--output_dir', type=str, required=True, help='Path to the output HDF5 file.')
    parser.add_argument('--ensemble', type=str, required=True, help="Ensemble name")
    args = parser.parse_args()
    return args.input_dir, args.output_dir, args.ensemble

def get_parameters(lines):

    header_conf = lines[0]
    Nconfs = lines.count(header_conf)

    end_first_conf = lines[1:].index(header_conf)
    last_line_first_conf = lines[end_first_conf+1-1].strip().split()

    print("Last line of first configuration:", last_line_first_conf)

    Nops = int(last_line_first_conf[1])+1
    NT = int(last_line_first_conf[2])+1

    return Nconfs, Nops, NT, header_conf

def load_txt(input_file):

    with open(input_file) as f:
        lines = f.readlines()

        Nconfs, Nops, NT, header_conf = get_parameters(lines)
        ops_data = np.empty((Nconfs, Nops, NT), dtype='f8')
        vev_data = np.empty((Nconfs, Nops), dtype='f8')

        print("Number of configurations:", Nconfs)
        print("Number of operators:", Nops)
        print("Number of time slices:", NT)

        iconf=-1
        for line in lines:
            if line == header_conf:
                iconf+= 1
                continue
            entries = line.strip().split()
            iop = int(entries[1])
            it = int(entries[2])
            re_value = float(entries[3])
            ops_data[iconf, iop, it] = re_value

        for iop in range(Nops):
            #NOTE NOTE NOTE: No longer needed the division by NT later.
            vev_data[:, iop] = np.average(ops_data[:, iop, :], axis=1)

    return ops_data, vev_data, Nconfs, Nops

def convert_to_hdf5(input_file, output_file, dataset_key, parameters_dict=None):

    ops_data, vev_data, Nconfs, Nops = load_txt(input_file)

    with h5py.File(output_file, 'a') as hf:

        subdir = hf.create_group(dataset_key)
        subdir.create_dataset(dataset_key+"_interp_ops", data=ops_data)
        subdir.create_dataset(dataset_key+"_vev", data=vev_data)

        for key, value in parameters_dict.items():
            subdir.create_dataset(key, data=value)

        Nshapes = int(Nops / parameters_dict['block_smear_steps'])
        subdir.create_dataset('Nmeas', data=Nconfs)
        subdir.create_dataset('Nops', data=Nops)
        subdir.create_dataset('Nshapes', data=Nshapes)

    print(f"Data successfully converted to {output_file}")

if __name__ == "__main__":

    # TODO: transfer this to a yaml file later. 
    parameters = {
        "M3": {
            'block_smear_steps': 5,
            'alpha_APE': 0.4,
            'alpha_D': 0.16,
            'ensemble': 'M3',
            'mfun': -1.01,
            'mas': -0.71, #This changes!
            'beta': 6.5,
            'NT': 96,
            'NX': 20,
            'NY': 20,
            'NZ': 20
        },
        "M4": {
        'block_smear_steps': 5,
        'alpha_APE': 0.4,
        'alpha_D': 0.16,
        'ensemble': 'M3',
        'mfun': -1.01,
        'mas': -0.70, #This changes!
        'beta': 6.5,
        'NT': 64,
        'NX': 20,
        'NY': 20,
        'NZ': 20
        }
    }

    input_data_dir, output_data_dir, ensemble = parse_args()
    ensemble_parameters = parameters[ensemble]

    A1mp_data = os.path.join(input_data_dir, f'{ensemble}_A1mp_result.out')
    A1pp_data = os.path.join(input_data_dir, f'{ensemble}_A1pp_result.out')
    output_hdf5 = os.path.join(output_data_dir, f'{ensemble}_glueball_operators.hdf5')

    convert_to_hdf5(A1mp_data, output_hdf5, 'A1mp', ensemble_parameters)
    convert_to_hdf5(A1pp_data, output_hdf5, 'A1pp', ensemble_parameters)
