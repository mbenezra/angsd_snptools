#!/bin/sh

sh list_bams.sh

sh download_hg19.sh

sh download_hg19anc.sh

sh download_jvarkit.sh

sh get_hapmap.sh

sh run_snptools_pileup.sh

sh run_snptools_varisite.sh

sh run_snptools_bamodel.sh

sh run_snptools_poprob.sh

sh run_snptools_prob2vcf.sh
