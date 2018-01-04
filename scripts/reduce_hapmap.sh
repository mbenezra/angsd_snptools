#!/bin/sh

mkdir collect

sed -e 's/^/chr/' prob2vcf_hapmap/sites.txt > collect/sites.txt

# one file in recode format
vcftools --gzvcf hapmap/hapmap_3.3.hg19.vcf.gz --keep indv.txt --positions collect/sites.txt --not-chr chrX --max-alleles 2 --recode --out collect/hapmap_3.3.CEU.hg19

sed -i '315783d' hapmap_3.3.CEU.hg19.recode.vcf

gzip -c collect/hapmap_3.3.CEU.hg19.recode.vcf > collect/hapmap_3.3.CEU.hg19.recode.vcf.gz

awk '{gsub(/^chr/,""); print}' collect/hapmap_3.3.CEU.hg19.recode.vcf > collect/hapmap_3.3.CEU.hg19.vcf

gzip -c collect/hapmap_3.3.CEU.hg19.vcf > collect/hapmap_3.3.CEU.hg19.vcf.gz

java -jar jvarkit/dist/bioalcidae.jar -f script.js collect/hapmap_3.3.CEU.hg19.vcf > collect/hapmap.hg19.gt

sed -i 's/\///g' collect/hapmap.hg19.gt

gzip -c collect/hapmap.hg19.gt > collect/hapmap.hg19.gt.gz

