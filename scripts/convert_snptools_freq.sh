#!/bin/sh

for number in `seq 1 22` 
do
	gunzip -c geno_snptools_freq/snptools.freq.chr$number.geno.gz > geno_snptools_freq/snptools.freq.chr$number.geno
	sed -i 's/CA/AC/g' geno_snptools_freq/snptools.freq.chr$number.geno
	sed -i 's/GA/AG/g' geno_snptools_freq/snptools.freq.chr$number.geno
	sed -i 's/GC/CG/g' geno_snptools_freq/snptools.freq.chr$number.geno
	sed -i 's/TA/AT/g' geno_snptools_freq/snptools.freq.chr$number.geno
	sed -i 's/TC/CT/g' geno_snptools_freq/snptools.freq.chr$number.geno
	sed -i 's/TG/GT/g' geno_snptools_freq/snptools.freq.chr$number.geno
	cut -f1,2,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60,63,66,69,72,75,78,81,84,87,90,93,96,99,102,105,108,111,114,117,120,123,126,129,132,135,138,141,144,147,150,153,156,159,162,165,168,171,174,177,180,183,186,189,192,195,198,201,204,207,210,213,216,219,222,225,228,231,234,237,240,243,246,249,252,255,258,261,264,267,270,273 geno_snptools_freq/snptools.freq.chr$number.geno > geno_snptools_freq/snptools.freq.chr$number.gt
	gzip -c geno_snptools_freq/snptools.freq.chr$number.gt > geno_snptools_freq/snptools.freq.chr$number.gt.gz
	cut -f1,2,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,58,61,64,67,70,73,76,79,82,85,88,91,94,97,100,103,106,109,112,115,118,121,124,127,130,133,136,139,142,145,148,151,154,157,160,163,166,169,172,175,178,181,184,187,190,193,196,199,202,205,208,211,214,217,220,223,226,229,232,235,238,241,244,247,250,253,256,259,262,265,268,271,274 geno_snptools_freq/snptools.freq.chr$number.geno > geno_snptools_freq/snptools.freq.chr$number.gl
	gzip -c geno_snptools_freq/snptools.freq.chr$number.gl > geno_snptools_freq/snptools.freq.chr$number.gl.gz
	cut -f1,2,3,4 geno_snptools_freq/snptools.freq.chr$number.geno > geno_snptools_freq/snptools.freq.chr$number.mm
	gzip -c geno_snptools_freq/snptools.freq.chr$number.mm > geno_snptools_freq/snptools.freq.chr$number.mm.gz
done

cat geno_snptools_freq/snptools.freq.chr{1..22}.gt > geno_snptools_freq/snptools.freq.hg19.gt
gzip -c geno_snptools_freq/snptools.freq.hg19.gt > geno_snptools_freq/snptools.freq.hg19.gt.gz
cat geno_snptools_freq/snptools.freq.chr{1..22}.gl > geno_snptools_freq/snptools.freq.hg19.gl
gzip -c geno_snptools_freq/snptools.freq.hg19.gl > geno_snptools_freq/snptools.freq.hg19.gl.gz
cat geno_snptools_freq/snptools.freq.chr{1..22}.mm > geno_snptools_freq/snptools.freq.hg19.mm
gzip -c geno_snptools_freq/snptools.freq.hg19.mm > geno_snptools_freq/snptools.freq.hg19.mm.gz
