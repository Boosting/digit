import numpy as np
from scipy.io import savemat, loadmat
import caffe
from os.path import join, splitext, split, abspath, isdir

def make_label():
	