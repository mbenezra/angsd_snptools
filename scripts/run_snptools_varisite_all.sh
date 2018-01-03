#!/bin/sh

mkdir varisite_all
cd varisite_all
ls ../ebds/*.ebd > ebd.list
for indv in `cat ../indv.txt`; do grep $indv ebd.list; done > ebds.list
rm ebd.list

for number in {1..22}; do echo /willerslev/software/snptools/varisite ebds.list $number ../hg19/chr$number.hg19.fa; done > varisite_all.txt

cat varisite_all.txt | parallel

cat {1..22}.sites.vcf > sites.vcf
