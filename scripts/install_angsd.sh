#!/bin/sh

git clone https://github.com/samtools/htslib.git
git clone https://github.com/angsd/angsd.git
cd htslib;make;cd ../angsd;make HTSSRC=../htslib
