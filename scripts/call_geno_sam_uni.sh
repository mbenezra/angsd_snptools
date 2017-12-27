#!/bin/sh

mkdir geno_sam_uni

for number in `seq 1 22`
do 
	echo angsd/angsd -sites hapmap/$number.sites.txt -bam bams.list -doMaf 2 -doMajorMinor 1 -r $number: -doGeno 23 -doPost 1 -GL 1 -out geno_sam_uni/sam.uni.chr$number
done > geno.sam.uni.txt

# cat geno.sam.uni.txt | parallel
