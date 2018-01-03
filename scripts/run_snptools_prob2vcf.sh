#!/bin/sh

for number in {1..22}; do echo /willerslev/software/snptools/prob2vcf poprob/prob $number.out.vcf.gz $number; done > prob2vcf.txt

cat prob2vcf.txt | parallel

vcf-concat 1.out.vcf.gz 2.out.vcf.gz 3.out.vcf.gz 4.out.vcf.gz 5.out.vcf.gz 6.out.vcf.gz 7.out.vcf.gz 8.out.vcf.gz 9.out.vcf.gz 10.out.vcf.gz 11.out.vcf.gz 12.out.vcf.gz 13.out.vcf.gz 14.out.vcf.gz 15.out.vcf.gz 16.out.vcf.gz 17.out.vcf.gz 18.out.vcf.gz 19.out.vcf.gz 20.out.vcf.gz 21.out.vcf.gz 22.out.vcf.gz | gzip -c > out.vcf.gz

mkdir prob2vcf

mv *.out.vcf.gz prob2vcf/.
mv out.vcf.gz prob2vcf/.

for number in {1..22}; do less -S prob2vcf/$number.out.vcf.gz | grep -P "^$number\t" | awk '{print $1"\t"$2}' > prob2vcf/$number.sites.txt; done

for number in {1..22}; do angsd/angsd sites index prob2vcf/$number.sites.txt; done

cat prob2vcf/1.sites.txt prob2vcf/2.sites.txt prob2vcf/3.sites.txt prob2vcf/4.sites.txt prob2vcf/5.sites.txt prob2vcf/6.sites.txt prob2vcf/7.sites.txt prob2vcf/8.sites.txt prob2vcf/9.sites.txt prob2vcf/10.sites.txt prob2vcf/11.sites.txt prob2vcf/12.sites.txt prob2vcf/13.sites.txt prob2vcf/14.sites.txt prob2vcf/15.sites.txt prob2vcf/16.sites.txt prob2vcf/17.sites.txt prob2vcf/18.sites.txt prob2vcf/19.sites.txt prob2vcf/20.sites.txt prob2vcf/21.sites.txt prob2vcf/22.sites.txt > prob2vcf/sites.txt

angsd/angsd sites index prob2vcf/sites.txt

head -n 10 indv.txt > prob2vcf/indv10.txt

vcftools --gzvcf prob2vcf/out.vcf.gz --keep prob2vcf/indv10.txt --recode --out prob2vcf/10indv.out

gzip -c prob2vcf/10indv.out.recode.vcf > prob2vcf/10indv.out.recode.vcf.gz
