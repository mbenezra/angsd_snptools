depth <- read.table("../depth/depth.all.txt")
plot(depth$V2, depth$V1, xlim = c(0, 30))
files <- (Sys.glob("../depth/depth.NA*.txt"))
lapply(files, function(x) {file <- read.table(x); points(file[,2], file[,1], type = "l")})
