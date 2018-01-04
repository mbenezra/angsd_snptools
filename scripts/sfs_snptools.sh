#!/bin/sh

mkdir sfs_snptools

angsd/angsd -sites prob2vcf_all/sites.txt -vcf-GL prob2vcf_all/10indv.out.recode.vcf.gz -doSaf 5 -fai hg19/hg19.fa.gz.fai -nind 10 -doMajorMinor 3 -out sfs_snptools/snptools.ceu -fold 1

angsd/misc/realSFS sfs_snptools/snptools.ceu.saf.idx > sfs_snptools/snptools.ceu.sfs
