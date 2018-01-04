roc <- function(true, gt, gl){
  # ta <- table(c(unique(row.names(true)),unique(row.names(gt))))
  # pos <- names(ta[ta==2])
  
  # true <- true[row.names(true)%in%pos,]
  # gt <- gt[row.names(gt)%in%pos,]
  # gl <- gl[row.names(gl)%in%pos,]
  
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
  it <- read.table(file) #[c(1:5000),]
  row.names(it) <- paste(it[,1], it[,2], sep = "_")
  it <- it[,-c(1,2)]
  names(it) <- indv
  return(it)
}

# loadIt2 <- function(file, indv) {
# #  it <- read.table(file) [-368490,]
#   it <- read.table(file)[c(1:1000),]
#   row.names(it) <- paste(it[,1], it[,2], sep = "_")
#   it <- it[,-c(1,2)]
#   names(it) <- indv
#   return(it)
# }
# 
# getPos <- function(true, gt) {
#   ta <- table(c(unique(row.names(true)),unique(row.names(gt))))
#   pos <- names(ta[ta==2])
#   return(pos)
# }

indv <- read.table("indv.txt")[,1]

hapmap.hg19 <- loadIt("final/hapmap.hg19.gt.gz", indv)

snptools.uni.gt <- loadIt("final/snptools.uni.hg19.gt.gz", indv)
snptools.uni.gl <- loadIt("final/snptools.uni.hg19.gl.gz", indv)
snptools.freq.gt <- loadIt("final/snptools.freq.hg19.gt.gz", indv)
snptools.freq.gl <- loadIt("final/snptools.freq.hg19.gl.gz", indv)

pos <- getPos(hapmap.hg19, snptools.uni.gt)

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

# size <- length(snptools.uni.roc$spe)
# samp <- sort(sample(size,floor(size/100), replace = F))

# png('myroc.png',width=1024,height=1024)
plot(1-snptools.uni.roc$spe, 1-snptools.uni.roc$sen, main = "ROC curve", xlab = "False positive rate", ylab = "True positive rate", col = 1, type = "l", xlim = c(0, 1), ylim = c(0, 1))
lines(1-snptools.freq.roc$spe, 1-snptools.freq.roc$sen, col = 2, type = "l")

lines(1-sam.uni.roc$spe, 1-sam.uni.roc$sen, col = 3, type = "l")
lines(1-sam.freq.roc$spe, 1-sam.freq.roc$sen, col = 4, type = "l")

lines(1-gatk.uni.roc$spe, 1-gatk.uni.roc$sen, col = 5, type = "l")
lines(1-gatk.freq.roc$spe, 1-gatk.freq.roc$sen, col = 6, type = "l")

legend("bottomright", c("SNPTOOLS uniform", "SNPTOOLS allele freq", "SAMTOOLS uniform", "SAMTOOLS allele freq", "GATK uniform", "GATK allele freq"), lwd = c(1,1,1,1,1,1), lty = c(1,1,1,1,1,1), col=c(1,2,3,4,5,6))
# dev.off()
