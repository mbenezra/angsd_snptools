#!/bin/sh

mkdir poprob_all
cd poprob_all

ls ../bamodel_all/*.raw > raws.list

/willerslev/software/snptools/poprob ../varisite_all/sites.vcf raws.list prob -b 25600
