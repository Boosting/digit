#!/bin/bash
DIR=$(dirname "$0")
cd $DIR
if [ ! -f mnist.mat ]; then
  wget http://zhaok-data.oss-cn-shanghai.aliyuncs.com/dataset/mnist/mnist.mat
fi
echo "Done!"
