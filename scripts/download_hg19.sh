#!/bin/sh

mkdir hg19

wget --timestamping 'http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/twoBitToFa' -O hg19/twoBitToFa 
wget --timestamping 'ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.2bit' -O hg19/hg19.2bit

chmod +x hg19/twoBitToFa
hg19/twoBitToFa hg19/hg19.2bit hg19/hg19.fa
bgzip -c hg19/hg19.fa > hg19/hg19.fa.gz
samtools faidx hg19/hg19.fa.gz
less -S hg19/hg19.fa.gz.fai | cut -c 4- > hg19/hg19.tmp
mv hg19/hg19.tmp hg19/hg19.fa.gz.fai

for number in {1..22}; do echo chr$number; done > hg19/chr.list
for chr in `cat ./hg19/chr.list`; do hg19/twoBitToFa hg19/hg19.2bit hg19/$chr.hg19.fa -seq=$chr; done
for chr in `cat ./hg19/chr.list`; do bgzip -c hg19/$chr.hg19.fa > hg19/$chr.hg19.fa.gz; done
for chr in `cat ./hg19/chr.list`; do samtools faidx hg19/$chr.hg19.fa.gz; done
for chr in `cat ./hg19/chr.list`; do less -S hg19/$chr.hg19.fa.gz.fai | cut -c 4- > hg19/$chr.tmp; done
for chr in `cat ./hg19/chr.list`; do mv hg19/$chr.tmp hg19/$chr.hg19.fa.gz.fai; done
