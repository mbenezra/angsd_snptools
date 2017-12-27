 ##run in R
#plot the results
nnorm <- function(x) x/sum(x)
#expected number of sites with 1:20 derived alleles
res <- rbind(
  GATK=scan("../sfs/gatk.ceu.sfs")[-1],
  ANGSD=scan("../sfs/angsd.ceu.sfs")[-1],
  SNPTOOLS=scan("../sfs/snptools.ceu.sfs")[-1]
)
colnames(res) <- 1:20

# density instead of expected counts
res <- t(apply(res,1,nnorm))

#plot the none ancestral sites
barplot(res,beside=T,legend=c("GATK","ANGSD","SNPTOOLS"),names=1:20,main="realSFS non ancestral sites")

#plot the polymorphic sites.
resPoly <- t(apply(res[,-20],1,nnorm))
barplot(resPoly,beside=T,legend=c("GATK","ANGSD","SNPTOOLS"),names=1:19,main="realSFS polymorphic sites")

#due the very limited amount of data lets
#downsample to 5 individuals (10 chromosome) and exclude fixed derived
downsampleSFS <- function(x,chr){ #x 1:2n , chr < 2n
    n<-length(x)
    mat <- sapply(1:chr,function(i) choose(1:n,i)*choose(n- (1:n),chr-i)/choose(n,chr))
    nnorm( as.vector(t(mat) %*% x)[-chr] )
}
resDown <- t(apply(res,1,downsampleSFS,chr=10))
barplot(resDown,beside=T,legend=c("GATK","ANGSD","SNPTOOLS"),names=1:9,main="realSFS downsampled polymorphic sites")


