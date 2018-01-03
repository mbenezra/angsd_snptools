#!/bin/sh

mkdir sfs_snptools

less -S bams.list | head -n 10 > sfs_snptools/CEU.filelist

angsd/angsd -vcf-GL prob2vcf/10indv.out.recode.vcf.gz -doSaf 5 -fai hg19/hg19.fa.gz.fai -anc hg19anc/chimpHg19.fa.gz -nind 10 -doMajorMinor 1 -out sfs_snptools/snptools.ceu

# angsd/angsd -sites prob2vcf/sites.txt -b sfs_snptools/CEU.filelist -anc hg19anc/chimpHg19.fa.gz -out sfs_snptools/snptools.ceu -dosaf 1 -gl 1 -ref hg19/hg19.fa.gz -domajorminor 3

angsd/misc/realSFS sfs_snptools/snptools.ceu.saf.idx > sfs_snptools/snptools.ceu.sfs
