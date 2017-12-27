#!/bin/sh

mkdir sfs_gatk

less -S bams.list | head -n 10 > sfs_gatk/CEU.filelist

angsd/angsd -sites prob2vcf/sites.txt -b sfs_gatk/CEU.filelist -anc hg19anc/chimpHg19.fa.gz -out sfs_gatk/gatk.ceu -dosaf 1 -gl 1 -ref hg19/hg19.fa.gz -domajorminor 3

realSFS sfs_gatk/gatk.ceu.saf.idx > sfs_gatk/gatk.ceu.sfs
