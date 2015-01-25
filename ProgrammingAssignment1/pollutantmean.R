pollutantmean <- function(directory, pollutant, id=1:332) {
     ### Return the mean of the pollutant across all monitors list
     ### in the 'id' vector (ignoring NA values)
     specfiles <- list.files(directory)
     dataframe <- data.frame()
     for (i in id) {
          data <- read.csv(paste("./", directory, "/", specfiles[i], sep=""))
          dataframe <- rbind(dataframe, data)
     }
     mean(dataframe[,pollutant], na.rm=TRUE)
}