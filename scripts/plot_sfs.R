 ##run in R
#plot the results
nnorm <- function(x) x/sum(x)
#expected number of sites with 1:10 derived alleles
res <- rbind(
  GATK=scan("sfs_gatk/gatk.ceu.sfs")[-1],
  SAMTOOLS=scan("sfs_sam/sam.ceu.sfs")[-1],
  SNPTOOLS=scan("sfs_snptools/snptools.ceu.sfs")[-1]
)

res2 <- rbind(
  GATK=scan("sfs_gatk/gatk.ceu.sfs"),
  SAMTOOLS=scan("sfs_sam/sam.ceu.sfs"),
  SNPTOOLS=scan("sfs_snptools/snptools.ceu.sfs")
)

colnames(res) <- 1:10

# density instead of expected counts
res <- t(apply(res,1,nnorm))

#plot the none ancestral sites
png('sfs.png',width=1024,height=1024)
barplot(res,beside=T,legend=c("GATK: 0.6100569 variability","SAMTOOLS: 0.6024786 variability","SNPTools: 0.6030279 variability"),names=1:10,main="Folded Site Frequency Spectrum (SFS)")
dev.off()

1-res2[,1]/rowSums(res2)

#plot the polymorphic sites.
# resPoly <- t(apply(res[,-10],1,nnorm))
# png('realSFS_ploymorphic_sites.png',width=1024,height=1024)
# barplot(resPoly,beside=T,legend=c("GATK","SAMTOOLS","SNPTOOLS"),names=1:9,main="realSFS polymorphic sites")
# dev.off()

#due the very limited amount of data lets
#downsample to 5 individuals (10 chromosome) and exclude fixed derived
##downsampleSFS <- function(x,chr){ #x 1:2n , chr < 2n
##    n<-length(x)
##    mat <- sapply(1:chr,function(i) choose(1:n,i)*choose(n- (1:n),chr-i)/choose(n,chr))
##    nnorm( as.vector(t(mat) %*% x)[-chr] )
##}
##resDown <- t(apply(res,1,downsampleSFS,chr=10))
##png('realSFS_downsampled_ploymorphic_sites.png',width=1024,height=1024)
##barplot(resDown,beside=T,legend=c("GATK","SAMTOOLS","SNPTOOLS"),names=1:9,main="realSFS downsampled polymorphic sites")
##dev.off()
