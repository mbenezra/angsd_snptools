#!/bin/sh

ls /willerslev/datasets/fvr124/1000g/*CEU*.bam > bam.list
for indv in `cat ../data/indv.txt`; do grep $indv bam.list; done > bams.list
rm bam.list
