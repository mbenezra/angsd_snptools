#!/bin/sh

for sample in `cat indv.txt`; do echo /willerslev/software/snptools/bamodel $sample varisite/sites.vcf `grep $sample bams.list | tr '\n' ' '`; done > bamodel.txt

cat bamodel.txt | head -n 20 | tail -n 20 | parallel
wait
cat bamodel.txt | head -n 40 | tail -n 20 | parallel
wait
cat bamodel.txt | head -n 60 | tail -n 20 | parallel
wait
cat bamodel.txt | head -n 80 | tail -n 20 | parallel
wait
cat bamodel.txt | head -n 99 | tail -n 19 | parallel

mkdir bamodel
mv *.emit bamodel/.
mv *.raw bamodel/.
mv *.weig bamodel/.
