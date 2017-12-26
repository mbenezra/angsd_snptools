#!/bin/sh

mkdir varisite
ls ebds/*.ebd > ebd.list
for indv in `cat indv.txt`; do grep $indv ebd.list; done > ebds.list
rm ebd.list
for number in {1..22}; do echo /willerslev/software/snptools/varisite -s 0 -v hapmap/hapmap_3.3.CEU.chr$number.hg19.vcf ebds.list $number hg19/chr$number.hg19.fa; done > varisite.txt

cat varisite.txt | parallel

cat 1.sites.vcf 2.sites.vcf 3.sites.vcf 4.sites.vcf 5.sites.vcf 6.sites.vcf 7.sites.vcf 8.sites.vcf 9.sites.vcf 10.sites.vcf 11.sites.vcf 12.sites.vcf 13.sites.vcf 14.sites.vcf 15.sites.vcf 16.sites.vcf 17.sites.vcf 18.sites.vcf 19.sites.vcf 20.sites.vcf 21.sites.vcf 22.sites.vcf > varisite/sites.vcf

mv *.sites.vcf varisite/.


#ls /storage/benezra/ebds2/*.ebd > ebd.list
#for indv in `cat indv.txt`; do grep $indv ebd.list; done > ebds.list
#for number in {1..22}; do echo /storage/benezra/bin/snptools/varisite ebds.list $number ./hg19/chr$number.hg19
#.fa; done > varisite.txt
#cat varisite.txt | parallel

#cat 1.sites.vcf 2.sites.vcf 3.sites.vcf 4.sites.vcf 5.sites.vcf 6.sites.vcf 7.sites.vcf 8.sites.vcf 9.sites.vcf 10.sites.vcf 11.sites.vcf 12.sites.vcf 13.sites.vcf 14.sites.vcf 15.sites.vcf 16.sites.vcf 17.sites.vcf 18.sites.vcf 19.sites.vcf 20.sites.vcf 21.sites.vcf 22.sites.vcf > sites.vcf
