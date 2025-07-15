import os

import zarr
import numpy as np
import pandas as pd
import torch.utils.data as data
import torch
import math
import sys

# from slide_dataset import SlideDataset
# import 


class CellCutterDataset(data.Dataset):
    def __init__(self, root_path = None, tile_size = None, quantification_path = None, q_start_index = None, q_end_index = None):
        self.root_path = root_path
        self.common_channel_names = pd.read_csv(quantification_path).columns[q_start_index : q_end_index]
        
        self.tile_size = tile_size
        self.data = zarr.open(f"{root_path}/output.zarr", mode='r')
        # data shape: dims x items x tile_size x tile_size
    
    def __getitem__(self, index):
        if index < self.__len__():
            return self.data[:, index, ...].astype(dtype="int64")
        return None

    def __len__(self):
        return self.data.shape[1]