#!/bin/sh

mkdir geno_sam_freq
cd geno_sam_freq

ls /willerslev/datasets/fvr124/1000g/*CEU*.bam > bam.list
for indv in `cat ../indv.txt`; do grep $indv bam.list; done > bams.list
rm bam.list

for number in {1..22}; do echo ../angsd/angsd -sites ../prob2vcf_hapmap/$number.sites.txt -bam bams.list -doMaf 1 -doMajorMinor 1 -r $number: -doGeno 23 -doPost 1 -GL 1 -out sam.freq.chr$number; done > geno.sam.freq.txt

cat geno.sam.freq.txt | parallel
