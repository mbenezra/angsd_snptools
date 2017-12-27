#!/bin/sh

wget http://popgen.dk/software/download/angsd/hg19ancNoChr.fa.gz
mkdir hg19anc
mv hg19ancNoChr.fa.gz hg19anc/hg19ancNoChr.fa.gz
mv hg19anc/hg19ancNoChr.fa.gz hg19anc/chimpHg19.fa.gz
samtools faidx hg19anc/chimpHg19.fa.gz
