#!/bin/sh

mkdir bamodel_all
cd bamodel_all

ls /willerslev/datasets/fvr124/1000g/*CEU*.bam > bam.list
for indv in `cat ../indv.txt`; do grep $indv bam.list; done > bams.list
rm bam.list

for sample in `cat ../indv.txt`; do echo /willerslev/software/snptools/bamodel $sample ../varisite_all/sites.vcf `grep $sample bams.list | tr '\n' ' '`; done > bamodel_all.txt

cat bamodel_all.txt | head -n 20 | tail -n 20 | parallel
wait
cat bamodel_all.txt | head -n 40 | tail -n 20 | parallel
wait
cat bamodel_all.txt | head -n 60 | tail -n 20 | parallel
wait
cat bamodel_all.txt | head -n 80 | tail -n 20 | parallel
wait
cat bamodel_all.txt | head -n 99 | tail -n 19 | parallel
