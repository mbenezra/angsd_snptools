#!/bin/sh

mkdir depth

samtools depth -f bams.list | cut -f3 | sort -n | uniq -c > depth/depth.all.txt
for sample in `cat indv.txt`; do samtools depth `grep $sample bams.list` | cut -f3 | sort -n | uniq -c > depth/depth.$sample.txt; done

for sample in `cat indv.txt`; do less -S depth/depth.$sample.txt | cut -f3 | sort -n | uniq -c > depth/cut.depth.$sample.txt; done
