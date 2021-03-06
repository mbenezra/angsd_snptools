roc <- function(true, gt, gl){
  
  true <- as.vector(unlist(true))
  gt <- as.vector(unlist(gt))
  gl <- as.vector(unlist(gl))
  
  score <- gl
  trueSet <- as.vector(unlist(gt))==as.vector(unlist(true))
  ord <- order(score)
  trueSet <- trueSet[ord]
  sen <- cumsum(trueSet)/sum(trueSet)
  spe <- cumsum(!trueSet)/sum(!trueSet)
  
  idx = min(which(gl[ord]>0.95))
  
  tbl <- c(sum(trueSet)-cumsum(trueSet)[idx], sum(trueSet), sum(!trueSet)-cumsum(!trueSet)[idx], sum(!trueSet))
  
  return (list("sen" = sen, "spe" = spe, "gl" = gl[ord], "idx" = idx, "tbl" = tbl))
}

comp <- function(true, gt, gl){
  
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
  
  # callrate <- cumsum(ag$trueSet)/length(gl)
  # errorrate <- 1-(cumsum(ag$trueSet)/cumsum(ag$num))
  
  callrate <- 1-cumsum(ag$num)/length(gl)
  errorrate <- (cumsum(ag$trueSet)/cumsum(ag$num))
  
  idx <- max(which(ag$gl>0.95))
  
  # tbl <- c(cumsum(ag$num)[idx], length(gl), cumsum(ag$trueSet), cumsum(ag$num))
  
  return(list("callrate" = callrate, "errorrate" = errorrate, "gl" = ag$gl, "idx" = idx))
}

loadIt <- function(file, indv) {
  it <- read.table(file)
  row.names(it) <- paste(it[,1], it[,2], sep = "_")
  it <- it[,-c(1,2)]
  names(it) <- indv
  return(it)
}

indv <- read.table("indv.txt")[,1]

hapmap.hg19 <- loadIt("final/hapmap.hg19.gt.gz", indv)

snptools.uni.gt <- loadIt("final/snptools.uni.hg19.gt.gz", indv)
snptools.uni.gl <- loadIt("final/snptools.uni.hg19.gl.gz", indv)
snptools.freq.gt <- loadIt("final/snptools.freq.hg19.gt.gz", indv)
snptools.freq.gl <- loadIt("final/snptools.freq.hg19.gl.gz", indv)

sam.uni.gt <- loadIt("final/sam.uni.hg19.gt.gz", indv)
sam.uni.gl <- loadIt("final/sam.uni.hg19.gl.gz", indv)
sam.freq.gt <- loadIt("final/sam.freq.hg19.gt.gz", indv)
sam.freq.gl <- loadIt("final/sam.freq.hg19.gl.gz", indv)

gatk.uni.gt <- loadIt("final/gatk.uni.hg19.gt.gz", indv)
gatk.uni.gl <- loadIt("final/gatk.uni.hg19.gl.gz", indv)
gatk.freq.gt <- loadIt("final/gatk.freq.hg19.gt.gz", indv)
gatk.freq.gl <- loadIt("final/gatk.freq.hg19.gl.gz", indv)



snptools.uni.roc <- roc(hapmap.hg19, snptools.uni.gt, snptools.uni.gl)
snptools.freq.roc <- roc(hapmap.hg19, snptools.freq.gt, snptools.freq.gl)

sam.uni.roc <- roc(hapmap.hg19, sam.uni.gt, sam.uni.gl)
sam.freq.roc <- roc(hapmap.hg19, sam.freq.gt, sam.freq.gl)

gatk.uni.roc <- roc(hapmap.hg19, gatk.uni.gt, gatk.uni.gl)
gatk.freq.roc <- roc(hapmap.hg19, gatk.freq.gt, gatk.freq.gl)

png('roc.png',width=1024,height=1024)
plot(1-snptools.uni.roc$spe, 1-snptools.uni.roc$sen, main = "ROC curve", xlab = "Specificity", ylab = "Sensitivity", col = 1, type = "l", xlim = c(0, 1), ylim = c(0, 1))
points(1-snptools.uni.roc$spe[snptools.uni.roc$idx], 1-snptools.uni.roc$sen[snptools.uni.roc$idx], pch = 23, cex = 2, col = 1)
print("snptools.uni.roc")
print(snptools.uni.roc$tbl)

lines(1-snptools.freq.roc$spe, 1-snptools.freq.roc$sen, col = 2, type = "l")
points(1-snptools.freq.roc$spe[snptools.freq.roc$idx], 1-snptools.freq.roc$sen[snptools.freq.roc$idx], pch = 23, cex = 2, col = 2)
print("snptools.freq.roc")
print(snptools.freq.roc$tbl)

lines(1-sam.uni.roc$spe, 1-sam.uni.roc$sen, col = 3, type = "l")
points(1-sam.uni.roc$spe[sam.uni.roc$idx], 1-sam.uni.roc$sen[sam.uni.roc$idx], pch = 23, cex = 2, col = 3)
print("sam.uni.roc")
print(sam.uni.roc$tbl)

lines(1-sam.freq.roc$spe, 1-sam.freq.roc$sen, col = 4, type = "l")
points(1-sam.freq.roc$spe[sam.freq.roc$idx], 1-sam.freq.roc$sen[sam.freq.roc$idx], pch = 23, cex = 2, col = 4)
print("sam.freq.roc")
print(sam.freq.roc$tbl)

lines(1-gatk.uni.roc$spe, 1-gatk.uni.roc$sen, col = 5, type = "l")
points(1-gatk.uni.roc$spe[gatk.uni.roc$idx], 1-gatk.uni.roc$sen[gatk.uni.roc$idx], pch = 23, cex = 2, col = 5)
print("gatk.uni.roc")
print(gatk.uni.roc$tbl)

lines(1-gatk.freq.roc$spe, 1-gatk.freq.roc$sen, col = 6, type = "l")
points(1-gatk.freq.roc$spe[gatk.freq.roc$idx], 1-gatk.freq.roc$sen[gatk.freq.roc$idx], pch = 23, cex = 2, col = 6)
print("gatk.freq.roc")
print(gatk.freq.roc$tbl)

legend("bottomright", c("SNPTools uniform prior", "SNPTools frequency prior", "SAMTOOLS uniform prior", "SAMTOOLS frequency prior", "GATK uniform prior", "GATK frequency prior"), lwd = c(1,1,1,1,1,1), lty = c(1,1,1,1,1,1), col=c(1,2,3,4,5,6), pch=c(23,23,23,23,23,23))
dev.off()

snptools.uni.comp <- comp(hapmap.hg19, snptools.uni.gt, snptools.uni.gl)
snptools.freq.comp <- comp(hapmap.hg19, snptools.freq.gt, snptools.freq.gl)

sam.uni.comp <- comp(hapmap.hg19, sam.uni.gt, sam.uni.gl)
sam.freq.comp <- comp(hapmap.hg19, sam.freq.gt, sam.freq.gl)

gatk.uni.comp <- comp(hapmap.hg19, gatk.uni.gt, gatk.uni.gl)
gatk.freq.comp <- comp(hapmap.hg19, gatk.freq.gt, gatk.freq.gl)

png('comparison.png',width=1024,height=1024)
plot(snptools.uni.comp$callrate, snptools.uni.comp$errorrate, main = "Comparison of genotype callers", xlab = "Proportion of non-calls", ylab = "Genotype call accuracy", col = 1, type = "l", xlim = c(0, 1), ylim = c(0.95, 1))
points(snptools.uni.comp$callrate[snptools.uni.comp$idx], snptools.uni.comp$errorrate[snptools.uni.comp$idx], pch = 23, cex = 2, col = 1)
# snptools.uni.comp$tbl

lines(snptools.freq.comp$callrate, snptools.freq.comp$errorrate, col = 2, type = "l")
points(snptools.freq.comp$callrate[snptools.freq.comp$idx], snptools.freq.comp$errorrate[snptools.freq.comp$idx], pch = 23, cex = 2, col = 2)
# snptools.uni.comp$tbl

lines(sam.uni.comp$callrate, sam.uni.comp$errorrate, col = 3, type = "l")
points(sam.uni.comp$callrate[sam.uni.comp$idx], sam.uni.comp$errorrate[sam.uni.comp$idx], pch = 23, cex = 2, col = 3)
# snptools.uni.comp$tbl

lines(sam.freq.comp$callrate, sam.freq.comp$errorrate, col = 4, type = "l")
points(sam.freq.comp$callrate[sam.freq.comp$idx], sam.freq.comp$errorrate[sam.freq.comp$idx], pch = 23, cex = 2, col = 4)
# snptools.uni.comp$tbl

lines(gatk.uni.comp$callrate, gatk.uni.comp$errorrate, col = 5, type = "l")
points(gatk.uni.comp$callrate[gatk.uni.comp$idx], gatk.uni.comp$errorrate[gatk.uni.comp$idx], pch = 23, cex = 2, col = 5)
# snptools.uni.comp$tbl

lines(gatk.freq.comp$callrate, gatk.freq.comp$errorrate, col = 6, type = "l")
points(gatk.freq.comp$callrate[gatk.freq.comp$idx], gatk.freq.comp$errorrate[gatk.freq.comp$idx], pch = 23, cex = 2, col = 6)
# snptools.uni.comp$tbl

legend("bottomright", c("SNPTools uniform prior", "SNPTools frequency prior", "SAMTOOLS uniform prior", "SAMTOOLS frequency prior", "GATK uniform prior", "GATK frequency prior"), lwd = c(1,1,1,1,1,1), lty = c(1,1,1,1,1,1), col=c(1,2,3,4,5,6), pch=c(23,23,23,23,23,23))
dev.off()


