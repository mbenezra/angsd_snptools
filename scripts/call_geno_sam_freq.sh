#!/bin/sh

mkdir geno_sam_freq

for number in `seq 1 22`
do 
	echo angsd/angsd -sites hapmap/$number.sites.txt -bam bams.list -doMaf 2 -doMajorMinor 1 -r $number: -doGeno 23 -doPost 2 -GL 1 -out geno_sam_freq/sam.freq.chr$number
done > geno.sam.freq.txt

# cat geno.sam.freq.txt | parallel
