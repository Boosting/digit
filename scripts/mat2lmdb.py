import numpy as np
from scipy.io import savemat, loadmat
# import caffe
from os.path import join, splitext, split, abspath, isdir
import shutil, os, argparse

parser = argparse.ArgumentParser(description='Convert Morph database to LMDB')
parser.add_argument('--data', type=str, help='Morph database directory', required=True)
args = args = parser.parse_args()
def make_db(data, db_path):
    if isdir(db_path):
        shutil.rmtree(db_path)
    os.makedirs(join(db_path, 'image'))
    os.makedirs(join(db_path, 'label'))
    # db_img = lmdb.open(join(db_path, 'image'), map_size=int(1e12))
    # db_lb = lmdb.open(join(db_path, 'image'), map_size=int(1e12))
    # txn_img, txn_lb = db_img.begin(write=True), db_lb.begin(write=True)
    items = [i for i in os.listdir(data) if '.mat' in i]
    print items

if __name__ == '__main__':
    make_db(args.data, 'data/lmdb')
	
