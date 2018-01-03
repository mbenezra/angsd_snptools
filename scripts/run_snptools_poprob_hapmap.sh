#!/bin/sh

mkdir poprob_hapmap
cd poprob_hapmap

ls ../bamodel_hapmap/*.raw > raws.list

/willerslev/software/snptools/poprob ../varisite_hapmap/sites.vcf raws.list prob -b 25600
