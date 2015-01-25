complete <- function(directory, id = 1:332) {
     #Return a data frame of the form:
     #id nobs
     #1  117
     #2  1041
     #...
     #where 'id' is the monitor ID number and 'nobs' is the
     #number of complete cases
     specfiles <- list.files(directory)
     dataframe <- data.frame()
     nobs <- numeric()
     for (i in seq_along(id)) {
          data <- read.csv(paste("./", directory, "/", specfiles[id[i]], sep=""))
          nobs[i] <- sum(complete.cases(data))
     }
     data.frame(id, nobs)
}