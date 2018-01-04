#!/bin/sh

mkdir sfs_gatk

less -S bams.list | head -n 10 > sfs_gatk/CEU.filelist

angsd/angsd -sites prob2vcf_all/sites.txt -b sfs_gatk/CEU.filelist -out sfs_gatk/gatk.ceu -doSaf 5 -GL 2 -doMajorMinor 3 -fold 1

angsd/misc/realSFS sfs_gatk/gatk.ceu.saf.idx > sfs_gatk/gatk.ceu.sfs
