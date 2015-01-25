corr <- function(directory, threshold=0) {     
     ### Return a numeric vector of correlations
     specfiles <- list.files(directory)
     corvector <- numeric()
     nobsdata <- complete(directory)
     for (i in seq_along(nobsdata$nobs)) {
          if(nobsdata$nobs[i] > threshold) {
               data <- read.csv(paste("./", directory, "/", specfiles[nobsdata$id[i]], sep=""))
               completedata <- data[complete.cases(data),]
               newval <- cor(completedata[,"sulfate"], completedata[,"nitrate"])
               corvector <- append(corvector, newval)
          }
     }
     return(corvector)
}