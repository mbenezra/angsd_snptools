#!/bin/sh

for number in `seq 1 22` 
do
	gunzip --keep geno_sam_uni/sam.uni.chr$number.geno.gz
	sed -i 's/CA/AC/g' geno_sam_uni/sam.uni.chr$number.geno
	sed -i 's/GA/AG/g' geno_sam_uni/sam.uni.chr$number.geno
	sed -i 's/GC/CG/g' geno_sam_uni/sam.uni.chr$number.geno
	sed -i 's/TA/AT/g' geno_sam_uni/sam.uni.chr$number.geno
	sed -i 's/TC/CT/g' geno_sam_uni/sam.uni.chr$number.geno
	sed -i 's/TG/GT/g' geno_sam_uni/sam.uni.chr$number.geno
	cut -f1,2,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,60,63,66,69,72,75,78,81,84,87,90,93,96,99,102,105,108,111,114,117,120,123,126,129,132,135,138,141,144,147,150,153,156,159,162,165,168,171,174,177,180,183,186,189,192,195,198,201,204,207,210,213,216,219,222,225,228,231,234,237,240,243,246,249,252,255,258,261,264,267,270,273 geno_sam_uni/sam.uni.chr$number.geno > geno_sam_uni/sam.uni.chr$number.gt
	gzip --keep geno_sam_uni/sam.uni.chr$number.gt
	cut -f1,2,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,58,61,64,67,70,73,76,79,82,85,88,91,94,97,100,103,106,109,112,115,118,121,124,127,130,133,136,139,142,145,148,151,154,157,160,163,166,169,172,175,178,181,184,187,190,193,196,199,202,205,208,211,214,217,220,223,226,229,232,235,238,241,244,247,250,253,256,259,262,265,268,271,274 geno_sam_uni/sam.uni.chr$number.geno > geno_sam_uni/sam.uni.chr$number.gl
	gzip --keep geno_sam_uni/sam.uni.chr$number.gl
	cut -f1,2,3,4 geno_sam_uni/sam.uni.chr$number.geno > geno_sam_uni/sam.uni.chr$number.mm
	gzip --keep geno_sam_uni/sam.uni.chr$number.mm
done

cat geno_sam_uni/sam.chr{1..22}.gt > geno_sam_uni/sam.uni.hg19.gt
gzip --keep geno_sam_uni/sam.uni.hg19.gt
cat geno_sam_uni/sam.uni.chr{1..22}.gl > geno_sam_uni/sam.uni.hg19.gl
gzip --keep geno_sam_uni/sam.uni.hg19.gl
cat geno_sam_uni/sam.uni.chr{1..22}.mm > geno_sam_uni/sam.uni.hg19.mm
gzip --keep geno_sam_uni/sam.uni.hg19.mm
