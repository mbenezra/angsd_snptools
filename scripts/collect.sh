#!/bin/sh

mkdir final

cp collect/hapmap.hg19.gt.gz final/hapmap.hg19.gt.gz
cp geno_snptools_uni/snptools.uni.hg19.gt.gz final/snptools.uni.hg19.gt.gz
cp geno_snptools_uni/snptools.uni.hg19.gl.gz final/snptools.uni.hg19.gl.gz
cp geno_snptools_freq/snptools.freq.hg19.gt.gz final/snptools.freq.hg19.gt.gz
cp geno_snptools_freq/snptools.freq.hg19.gl.gz final/snptools.freq.hg19.gl.gz

cp geno_sam_uni/sam.uni.hg19.gt.gz final/sam.uni.hg19.gt.gz
cp geno_sam_uni/sam.uni.hg19.gl.gz final/sam.uni.hg19.gl.gz
cp geno_sam_freq/sam.freq.hg19.gt.gz final/sam.freq.hg19.gt.gz
cp geno_sam_freq/sam.freq.hg19.gl.gz final/sam.freq.hg19.gl.gz

cp geno_gatk_uni/gatk.uni.hg19.gt.gz final/gatk.uni.hg19.gt.gz
cp geno_gatk_uni/gatk.uni.hg19.gl.gz final/gatk.uni.hg19.gl.gz
cp geno_gatk_freq/gatk.freq.hg19.gt.gz final/gatk.freq.hg19.gt.gz
cp geno_gatk_freq/gatk.freq.hg19.gl.gz final/gatk.freq.hg19.gl.gz

less -S final/hapmap.hg19.gt.gz | head -n 1000 > final/hapmap.hg19.gt
less -S final/snptools.uni.hg19.gt.gz | head -n 1000 > final/snptools.uni.hg19.gt
less -S final/snptools.uni.hg19.gl.gz | head -n 1000 > final/snptools.uni.hg19.gl
less -S final/snptools.freq.hg19.gt.gz | head -n 1000 > final/snptools.freq.hg19.gt
less -S final/snptools.freq.hg19.gl.gz | head -n 1000 > final/snptools.freq.hg19.gl

less -S final/sam.uni.hg19.gt.gz | head -n 1000 > final/sam.uni.hg19.gt
less -S final/sam.uni.hg19.gl.gz | head -n 1000 > final/sam.uni.hg19.gl
less -S final/sam.freq.hg19.gt.gz | head -n 1000 > final/sam.freq.hg19.gt
less -S final/sam.freq.hg19.gl.gz | head -n 1000 > final/sam.freq.hg19.gl

less -S final/gatk.uni.hg19.gt.gz | head -n 1000 > final/gatk.uni.hg19.gt
less -S final/gatk.uni.hg19.gl.gz | head -n 1000 > final/gatk.uni.hg19.gl
less -S final/gatk.freq.hg19.gt.gz | head -n 1000 > final/gatk.freq.hg19.gt
less -S final/gatk.freq.hg19.gl.gz | head -n 1000 > final/gatk.freq.hg19.gl
