#!/bin/sh

mkdir geno_snptools_uni

# angsd/angsd -sites hapmap/sites.txt -vcf-GL prob2vcf/out.vcf.gz -nInd 90 -SNP_pval 0.001 -doMajorMinor 1 -doGeno 18 -doPost 1 -out genp_snptools_uni/snptools.uni -fai hg19/hg19.fa.gz.fai -doMaf 1

for number in {1..22}; do echo angsd/angsd -sites hapmap/$number.sites.txt -vcf-GL prob2vcf/$number.out.vcf.gz -nInd 90 -doMajorMinor 1 -r $number: -doGeno 18 -doPost 1 -out geno_snptools_uni/snptools.uni.chr$number -fai hg19/chr$number.hg19.fa.gz.fai -doMaf 1; done > geno.snptools.uni.txt

cat geno.snptools.uni.txt | parallel
