#!/bin/sh

mkdir geno_snptools_freq
cd geno_snptools_freq

for number in {1..22}; do echo ../angsd/angsd -sites ../prob2vcf_hapmap/$number.sites.txt -vcf-GL ../prob2vcf_hapmap/$number.out.vcf.gz -nInd 90 -doMajorMinor 1 -r $number: -doGeno 23 -doPost 1 -out snptools.freq.chr$number -fai ../hg19/chr$number.hg19.fa.gz.fai -doMaf 1; done > geno.snptools.freq.txt

cat geno.snptools.freq.txt | parallel
