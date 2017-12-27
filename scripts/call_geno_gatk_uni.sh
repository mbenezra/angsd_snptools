#!/bin/sh

mkdir geno_gatk_uni

for number in `seq 1 22`
do 
	echo angsd/angsd -sites hapmap/$number.sites.txt -bam bams.list -doMaf 2 -doMajorMinor 1 -r $number: -doGeno 23 -doPost 1 -GL 2 -out geno_gatk_uni/gatk.uni.chr$number
done > geno.gatk.uni.txt

# cat geno.gatk.uni.txt | parallel
