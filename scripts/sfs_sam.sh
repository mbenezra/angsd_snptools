#!/bin/sh

mkdir sfs_sam

less -S bams.list | head -n 10 > sfs_sam/CEU.filelist

angsd/angsd -sites prob2vcf_all/sites.txt -b sfs_sam/CEU.filelist -out sfs_sam/sam.ceu -doSaf 5 -GL 1 -doMajorMinor 3 -fold 1

angsd/misc/realSFS sfs_sam/sam.ceu.saf.idx > sfs_sam/sam.ceu.sfs
