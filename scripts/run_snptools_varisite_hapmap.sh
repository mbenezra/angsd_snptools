#!/bin/sh

mkdir varisite_hapmap
cd varisite_hapmap
ls ../ebds/*.ebd > ebd.list
for indv in `cat ../indv.txt`; do grep $indv ebd.list; done > ebds.list
rm ebd.list

for number in {1..22}; do echo /willerslev/software/snptools/varisite -v ../hapmap/hapmap_3.3.CEU.chr$number.hg19.vcf ebds.list $number ../hg19/chr$number.hg19.fa; done > varisite_hapmap.txt

cat varisite_hapmap.txt | parallel

cat {1..22}.sites.vcf > sites.vcf
