#!/bin/bash
rm -rf .git
rm -rf caffe
git init
git add -A
git submodule add https://github.com/BVLC/caffe caffe
git add data/get_mnist.sh -f
git commit -m "Init"
git remote add origin git@github.com:shucv/digit
git push -u origin master -f
echo "Done!"

