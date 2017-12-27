#!/bin/sh

mkdir geno_gatk_freq

for number in `seq 1 22`
do 
	echo angsd/angsd -sites hapmap/$number.sites.txt -bam bams.list -doMaf 2 -doMajorMinor 1 -r $number: -doGeno 23 -doPost 2 -GL 2 -out geno_gatk_freq/gatk.freq.chr$number
done > geno.gatk.freq.txt

# cat geno.gatk.freq.txt | parallel
