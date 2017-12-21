#!/bin/sh

# COPY HAPMAP
mkdir hapmap
cp /willerslev/users-shared/science-snm-willerslev-lxc844/data/hapmap_3.3.hg19.vcf.gz hapmap/.

# 1..22 in 012 format
for number in {1..22}; do vcftools --gzvcf hapmap/hapmap_3.3.hg19.vcf.gz --012 --max-alleles 2 --keep indv.txt --chr chr$number --out hapmap/hapmap_3.3.CEU.chr$number.hg19; done

for number in {1..22}; do less -S hapmap/hapmap_3.3.CEU.chr$number.hg19.012.pos | cut -c 4- > hapmap/$number.sites.txt; done

for number in {1..22}; do angsd/angsd sites index hapmap/$number.sites.txt; done

# one file in 012 format
vcftools --gzvcf hapmap/hapmap_3.3.hg19.vcf.gz --012 --max-alleles 2 --keep indv.txt --not-chr chrX --out hapmap/hapmap_3.3.CEU.hg19

less -S hapmap/hapmap_3.3.CEU.hg19.012.pos | cut -c 4- > hapmap/sites.txt

angsd/angsd sites index hapmap/sites.txt

# 1..22 in recode format
for number in {1..22}; do vcftools --gzvcf hapmap/hapmap_3.3.hg19.vcf.gz --keep indv.txt --chr chr$number --max-alleles 2 --recode --out hapmap/hapmap_3.3.CEU.chr$number.hg19; done

for number in {1..22}; do gzip --keep hapmap/hapmap_3.3.CEU.chr$number.hg19.recode.vcf; done

for number in {1..22}; do awk '{gsub(/^chr/,""); print}' hapmap/hapmap_3.3.CEU.chr$number.hg19.recode.vcf > hapmap/hapmap_3.3.CEU.chr$number.hg19.vcf; done

for number in {1..22}; do gzip --keep hapmap/hapmap_3.3.CEU.chr$number.hg19.vcf; done

# one file in recode format
vcftools --gzvcf hapmap/hapmap_3.3.hg19.vcf.gz --keep indv.txt --not-chr chrX --max-alleles 2 --recode --out hapmap/hapmap_3.3.CEU.hg19

gzip --keep hapmap/hapmap_3.3.CEU.hg19.recode.vcf
