#!/bin/sh

ls bamodel/*.raw > raws.list
/willerslev/software/snptools/poprob varisite/sites.vcf raws.list prob -b 25600

mkdir poprob
mv prob poprob/.
