#!/bin/sh

cat bams.list | head -n 20 | tail -n 20 | parallel /willerslev/software/snptools/pileup
wait
cat bams.list | head -n 40 | tail -n 20 | parallel /willerslev/software/snptools/pileup
wait
cat bams.list | head -n 60 | tail -n 20 | parallel /willerslev/software/snptools/pileup
wait
cat bams.list | head -n 80 | tail -n 20 | parallel /willerslev/software/snptools/pileup
wait
cat bams.list | head -n 90 | tail -n 10 | parallel /willerslev/software/snptools/pileup

for bam in `cat bams.list`; do /willerslev/software/snptools/pileup $bam; done
