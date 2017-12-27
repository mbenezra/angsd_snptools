roc <- function(true, gt, gl, pos){
  # ta <- table(c(unique(row.names(true)),unique(row.names(gt))))
  # pos <- names(ta[ta==2])
  
  true <- true[row.names(true)%in%pos,]
  gt <- gt[row.names(gt)%in%pos,]
  gl <- gl[row.names(gl)%in%pos,]
  
  true <- as.vector(unlist(true))
  gt <- as.vector(unlist(gt))
  gl <- as.vector(unlist(gl))
  
  score <- gl
  trueSet <- as.vector(unlist(gt))==as.vector(unlist(true))
  ord <- order(score)
  trueSet <- trueSet[ord]
  sen <- cumsum(trueSet)/sum(trueSet)
  spe <- cumsum(!trueSet)/sum(!trueSet)
  
  return (list("sen" = sen, "spe" = spe))
}

comp <- function(true, gt, gl, pos){
  true <- true[row.names(true)%in%pos,]
  gt <- gt[row.names(gt)%in%pos,]
  gl <- gl[row.names(gl)%in%pos,]
  
  true <- as.vector(unlist(true))
  gt <- as.vector(unlist(gt))
  gl <- as.vector(unlist(gl))
  
  trueSet <- as.vector(unlist(gt))==as.vector(unlist(true))
  ord <- order(gl, decreasing = T)
  trueSet <- trueSet[ord]
  
  gl <- gl[ord]
  num <- rep(1, length(gl))
  df <- cbind(trueSet, num, gl)
  ag <- aggregate(cbind(trueSet, num) ~ gl, df, sum)
  ag <- ag[order(ag$gl, decreasing = T),]
  
  callrate <- cumsum(ag$trueSet)/length(gl)
  errorrate <- 1-(cumsum(ag$trueSet)/cumsum(ag$num))
  
  return(list("callrate" = callrate, "errorrate" = errorrate))
}

loadIt <- function(file, indv) {
  it <- read.table(file)[c(1:1000),]
  row.names(it) <- paste(it[,1], it[,2], sep = "_")
  it <- it[,-c(1,2)]
  names(it) <- indv
  return(it)
}

getPos <- function(true, gt) {
  ta <- table(c(unique(row.names(true)),unique(row.names(gt))))
  pos <- names(ta[ta==2])
  return(pos)
}

indv <- read.table("../indv.txt")[,1]

hapmap.hg19 <- loadIt("../hapmap/hapmap.hg19.gt.gz", indv)

snptools.uni.gt <- loadIt("../snptools/snptools.uni.hg19.gt.gz", indv)
snptools.uni.gl <- loadIt("../snptools/snptools.uni.hg19.gl.gz", indv)
snptools.freq.gt <- loadIt("../snptools/snptools.freq.hg19.gt.gz", indv)
snptools.freq.gl <- loadIt("../snptools/snptools.freq.hg19.gl.gz", indv)

pos <- getPos(hapmap.hg19, snptools.uni.gt)

angsd.uni.gt <- loadIt("../angsd/angsd.uni.hg19.gt.gz", indv)
angsd.uni.gl <- loadIt("../angsd/angsd.uni.hg19.gl.gz", indv)
angsd.freq.gt <- loadIt("../angsd/angsd.freq.hg19.gt.gz", indv)
angsd.freq.gl <- loadIt("../angsd/angsd.freq.hg19.gl.gz", indv)

gatk.uni.gt <- loadIt("../gatk/gatk.uni.hg19.gt.gz", indv)
gatk.uni.gl <- loadIt("../gatk/gatk.uni.hg19.gl.gz", indv)
gatk.freq.gt <- loadIt("../gatk/gatk.freq.hg19.gt.gz", indv)
gatk.freq.gl <- loadIt("../gatk/gatk.freq.hg19.gl.gz", indv)

snptools.uni.roc <- comp(hapmap.hg19, snptools.uni.gt, snptools.uni.gl, pos)
snptools.freq.roc <- comp(hapmap.hg19, snptools.freq.gt, snptools.freq.gl, pos)

angsd.uni.roc <- comp(hapmap.hg19, angsd.uni.gt, angsd.uni.gl, pos)
angsd.freq.roc <- comp(hapmap.hg19, angsd.freq.gt, angsd.freq.gl, pos)

gatk.uni.roc <- comp(hapmap.hg19, gatk.uni.gt, gatk.uni.gl, pos)
gatk.freq.roc <- comp(hapmap.hg19, gatk.freq.gt, gatk.freq.gl, pos)

# size <- length(snptools.uni.roc$spe)
# samp <- sort(sample(size,floor(size/100), replace = F))

plot(snptools.uni.roc$callrate, snptools.uni.roc$errorrate, main = "Error rate vs call rate for called genotypes", xlab = "Call rate", ylab = "Error rate", col = 1, type = "l", xlim = c(0, 1), ylim = c(0, 0.05))
lines(snptools.freq.roc$callrate, snptools.freq.roc$errorrate, col = 2, type = "l")

lines(angsd.uni.roc$callrate, angsd.uni.roc$errorrate, col = 3, type = "l")
lines(angsd.freq.roc$callrate, angsd.freq.roc$errorrate, col = 4, type = "l")

lines(gatk.uni.roc$callrate, gatk.uni.roc$errorrate, col = 5, type = "l")
lines(gatk.freq.roc$callrate, gatk.freq.roc$errorrate, col = 6, type = "l")

legend("topleft", c("SNPTOOLS uniform", "SNPTOOLS allele freq", "SAMTOOLS uniform", "SAMTOOLS allele freq", "GATK uniform", "GATK allele freq"), lwd = c(1,1,1,1,1,1), lty = c(1,1,1,1,1,1), col=c(1,2,3,4,5,6))

