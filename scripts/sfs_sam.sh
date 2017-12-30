#!/bin/sh

mkdir sfs_sam

less -S bams.list | head -n 10 > sfs_sam/CEU.filelist

angsd/angsd -sites prob2vcf/sites.txt -b sfs_sam/CEU.filelist -anc hg19anc/chimpHg19.fa.gz -out sfs_sam/sam.ceu -doSaf 5 -GL 1 -ref hg19/hg19.fa.gz -doMajorMinor 1

angsd/misc/realSFS sfs_sam/sam.ceu.saf.idx > sfs_sam/sam.ceu.sfs
