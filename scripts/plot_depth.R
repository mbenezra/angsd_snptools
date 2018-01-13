files <- (Sys.glob("depth/cut.depth.NA*.txt"))

png('depth.png',width=1024,height=1024)
plot(0, 0, type="l", xlim = c(0, 30), ylim = c(0, 0.23), xlab = "Depth", ylab = "Density", main = "Distribution of depths")
s <- lapply(files, function(x) {file <- read.table(x); points(file$V2[c(1:31)], file$V1[c(1:31)]/sum(as.numeric(file$V1)), type = "l"); file$V1[c(1:31)]})
m <- matrix(unlist(s), ncol = 90)
points(0:30, rowSums(m)/sum(as.numeric(m)), type = "l", col = 2, lwd = 4)
dev.off()
