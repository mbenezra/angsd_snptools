#!/bin/sh

mkdir geno_gatk_freq
cd geno_gatk_freq

ls /willerslev/datasets/fvr124/1000g/*CEU*.bam > bam.list
for indv in `cat ../indv.txt`; do grep $indv bam.list; done > bams.list
rm bam.list

for number in {1..22}; do echo ../angsd/angsd -sites ../prob2vcf_hapmap/$number.sites.txt -bam bams.list -doMaf 1 -doMajorMinor 1 -r $number: -doGeno 23 -doPost 1 -GL 2 -out gatk.freq.chr$number; done > geno.gatk.freq.txt

cat geno.gatk.freq.txt | parallel
