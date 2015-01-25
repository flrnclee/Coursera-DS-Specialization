## GettingDataProject1

### About the Data
The data used in this project were pulled from the University of California, Irvine's [Human Activity Recognition Using Smartphones Study](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The purpose of this study was to determine whether smartphones could effectively capture human activity using its in-built features. 

During the Activity Recognition study, 30 volunteers, between the ages of 19 and 48, performed six different activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) while wearing a Samsung Galaxy S II on their waists. The accelorometer and gyroscope in the device captured 3-axial linear acceleration and 3-axial angular velocity measurements, along with other measured and calculated values. In total, there were 17 total signals, and data collected from these signals were outputted to the Human Activity Recognition Using Smartphones Data Set.

There are several folders to the dataset provided by the UCI Machine Learning repository, but only a few are used for this project:

* The __test folder__ contains data from the 9 volunteers who were randomly partitioned to the test group. 
     + ```subject_test.txt``` contains a vector of subject identification codes to attribute each set of feature measurements to a subject
     + ```X_test.txt``` contains feature measurements for each subject performing each activity during each window of time
     + ```y_test.txt``` contains a vector of activity codes to atrribute each set of feature measurements to an activity
* The __train folder__ contains data from the 21 volunteers who were randomly partitioned to the trainin group.
     + ```subject_train.txt```
     + ```X_train.txt```
     + ```y_train.txt```
* ```activity_labels.txt``` contains each activity code and its corresponding label.
* ```features.txt``` contains a vector of the different features measured in the study.

### About the Code
There are two files in GettingDataProject1:

* ```run_analysis.R``` is R code that takes takes the unzipped dataset provided by the UCI  Machine Learning Repository, merges the training and test data, selects the feature measurements pertaining to mean and standard deviations, and outputs a tidy dataset.
* ```uci_tidy.txt``` is the outputted tidy dataset. It contains the average feature measurements for each possible subject-activity pair. 

#### run_analysis.R
In order for ```run_analysis.R``` to run popularly, the UCI HAR Dataset must be unzipped and the working directory must be set to the location of the unzipped folder. The separate files and folders within the UCI HAR Dataset do not need to be moved out of the parent folder.

The ```run_analysis.R``` includes comments that document what each function and statement chunk accomplishes. As a summary, the code:

1. Loads the necessary packages, including ```dplyr``` and ```tidyr```.
2. Creates functions that will help read the training and test files.
3. Reads in the .txt files necessary to create ```uci_tidy.txt```.
4. Renames the columns of the data in ```X_train``` and ```X_test``` using the vector in ```features.txt```.
5. Labels the activity codes in ```y_test``` and ```y_train``` with their corresponding activity label using the data in ```activity_labels.txt```.
6. Merges the data in ```subject_test``` and ```subject_train``` with their corresponding activities and measurements to create two datasets: one for test subjects and one for training subjects.
7. Combines the data from test subjects with the data from training subjects. 
8. Selects features that contain mean and standard deviation measurements. 
     + ```meanFreq()``` features were excluded because they contained weighted averages of the frequency components rather than means of the direct measurements. 
     + All mean and standard deviation features for magnitudes were included despite the fact that these were calculated values. Magnitudes provide information not provided by the individual axial measurements.
9. Creates tidy dataset by grouping the data by subject, activity, and feature, and calculating the average feature measurement for each group.

### uci_tidy.txt
Below is the codebook for the data in ```uci_tidy.txt```. Note:
* For each measure feature (e.g. ```tBodyAcc```), the mean and standard deviation of the signals collected during that window of time were taken for each axis (X, Y, Z). The codebook only defines the signal labels and omits the specifics of each signal estimate.
* Magnitude measurements (e.g. ```tBodyAccMag```) are calculated from the individual axis measurements. Thus, they do not have individual axis values.

There are 180 observations and 68 variables in the final dataset.

Variable     | Label
------------- | -------------
subject_id | Identification number (1 to 30) for each study participant
activity_label | Activity performed by the subject
tBodyAcc | Body acceleration in the time domain
tGravityAcc | Gravity acceleration in the time domain
tBodyAccJerk   | Body acceleration jerk in the time domain
tBodyGyro | Body angular speed in the time domain
tBodyGyroJerk | Body angular acceleration in the time domain
tBodyAccMag | Body acceleration magnitude in the time domain
tGravityAccMag | Gravity acceleration magnitude in the time domain
tBodyAccJerkMag | Body acceleration jerk magnitude in the time domain
tBodyGyroMag | Body angular speed magnitude in the time domain
tBodyGyroJerkMag | Body angular acceleration magnitude in the time domain
fBodyAcc | Body acceleration in the frequency domain
fBodyAccJerk   | Body acceleration jerk in the frequency domain
fBodyGyro | Body angular speed in the frequency domain
fBodyAccMag | Body acceleration magnitude in the frequency domain
fBodyBodyAccJerkMag | Body acceleration jerk magnitude in the frequency domain
fBodyBodyGyroMag | Body angular speed magnitude in the frequency domain
fBodyBodyGyroJerkMag | Body angular acceleration magnitude in the frequency domain
