#!/bin/sh

mkdir geno_snptools_freq

# angsd/angsd -sites hapmap/sites.txt -vcf-GL prob2vcf/out.vcf.gz -nInd 90 -SNP_pval 0.001 -doMajorMinor 1 -doGeno 18 -doPost 2 -out genp_snptools_freq/snptools.freq -fai hg19/hg19.fa.gz.fai -doMaf 1

for number in {1..22}; do echo angsd/angsd -sites hapmap/$number.sites.txt -vcf-GL prob2vcf/$number.out.vcf.gz -nInd 90 -doMajorMinor 1 -r $number: -doGeno 18 -doPost 2 -out geno_snptools_freq/snptools.freq.chr$number -fai hg19/chr$number.hg19.fa.gz.fai -doMaf 1; done > geno.snptools.freq.txt

cat geno.snptools.freq.txt | parallel
