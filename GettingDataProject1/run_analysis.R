#NOTE: This code assumes UCI HAR Data folder is in working directory
#Code is written to extract files from UCI HAR Data folder

#Load packages
#NOTE: Packages must be loaded in this order.
library(plyr)
library(dplyr)
library(tidyr)

#Create functions
selectTxtFiles <- function(folder) {
     #selects text files in folder
     folder_files <- list.files(folder)
     txt_files <- folder_files[grep(pattern = ".txt", x = folder_files, perl = TRUE)] 
     return(txt_files)
}
createFilePath <- function(path, files) {
     #create file path to text files
     filepath <- vector()
     for(i in seq_along(files)) {
          filepath[i] <- paste(path, files[i], sep="")     
     }
     return(filepath)
}
readFile <- function(filepath) {
     #read file 
     read.table(filepath, header=FALSE)
}
createListData <- function(input) {
     #create a list of all data from folder
     folder <- input
     files <- selectTxtFiles(folder)
     file_paths <- createFilePath(folder, files)
     data <- lapply(file_paths, readFile)
     names(data) <- tolower(unlist(strsplit(files, '.txt')))
     return(data)
}
checkDim <- function(list) {
     #check dimensions of each element in list
     for (i in  names(list)) {
          print(dim(list[[i]]))
     }
}

#Read in test data
test_folder <- "UCI HAR Dataset/test/"
list_test_data <- createListData(test_folder)
#Read in train data
train_folder <- "UCI HAR Dataset/train/"
list_train_data <- createListData(train_folder)
#Read in features data
features <- readFile("UCI HAR Dataset/features.txt") 
#Read in activity labels
activity_labels <- readFile("UCI HAR Dataset/activity_labels.txt")

#Assign feature names to x_test/x_train 
feature_names <- as.character(features$V2)
names(list_test_data$x_test) <- feature_names
names(list_train_data$x_train) <- feature_names

#Join activity labels to corresponding activity in y_test/y_train
test_activities <- join(activity_labels, list_test_data$y_test, by="V1", type="right")
names(test_activities) <- c("activity_num", "activity_label")
train_activities <- join(activity_labels, list_train_data$y_train, by="V1", type="right")
names(train_activities) <- c("activity_num", "activity_label")

#Join subject_test and _activities to main dataset 
names(list_test_data$subject_test) <- c("subject_id")
names(list_train_data$subject_train) <- c("subject_id")
test_data <- cbind(list_test_data$subject_test, test_activities, list_test_data$x_test)
train_data <- cbind(list_train_data$subject_train, train_activities, list_train_data$x_train)

#Set train and test datasets together
uci_data <- rbind(test_data, train_data)

#Select the mean() and std() measurement columns.
col_select <- grep(".((\\-mean\\(\\))|(\\-std\\(\\)))", names(uci_data))
uci_data_use <- uci_data[, c(1, 3, col_select)] #drops activity_num
names(uci_data_use) <- gsub("-", "_", names(uci_data_use))
names(uci_data_use) <- gsub("\\(\\)", "", names(uci_data_use))

#Create tidy dataset
uci_tidy <- gather(uci_data_use, feature, measurement, -subject_id, -activity_label) %>%
               group_by(subject_id, activity_label, feature) %>%
                    summarize(avg_measurement=mean(measurement)) %>%
                         spread(feature, avg_measurement)

#write.table(uci_tidy, "./uci_tidy.txt")