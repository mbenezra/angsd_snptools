#!/bin/sh

mkdir prob2vcf_hapmap
cd prob2vcf_hapmap

for number in {1..22}; do echo /willerslev/software/snptools/prob2vcf ../poprob_hapmap/prob $number.out.vcf.gz $number; done > prob2vcf_hapmap.txt

cat prob2vcf_hapmap.txt | parallel

vcf-concat {1..22}.out.vcf.gz | gzip -c > out.vcf.gz

for number in {1..22}; do less -S $number.out.vcf.gz | grep -P "^$number\t" | awk '{print $1"\t"$2}' > $number.sites.txt; done

for number in {1..22}; do ../angsd/angsd sites index $number.sites.txt; done

cat {1..22}.sites.txt > sites.txt

../angsd/angsd sites index sites.txt

head -n 10 ../indv.txt > indv10.txt

vcftools --gzvcf out.vcf.gz --keep indv10.txt --recode --out 10indv.out

gzip -c 10indv.out.recode.vcf > 10indv.out.recode.vcf.gz
