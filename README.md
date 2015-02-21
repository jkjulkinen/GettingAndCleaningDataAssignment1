# README
Jari Kaljunen  
Saturday, February 21, 2015  

This is README-file for Coursera course Getting And Cleaning Data assignment 1.

The task of the assignment is to :

        _You should create one R script called run\_analysis.R that does the following. 
        Merges the training and the test sets to create one data set.
        Extracts only the measurements on the mean and standard deviation for each measurement. 
        Uses descriptive activity names to name the activities in the data set
        Appropriately labels the data set with descriptive variable names. 
        From the data set in step 4, creates a second, independent tidy data set with the average of each variable                 for each activity and each subject.
         
         Create a repo with README.md in the repo describing how the script works and the code book describing the variables.
        _


# Description of the script:

I is assumed that the actual file are to be found in the working directory.

The data column names are read:

```r
library(stringr)


rawcolnames <- read.table("features.txt")
datacolnames <- rawcolnames[,2]
```



The measurements data is read and column names are added: 

```r
xtrain <- read.table("X_train.txt")
colnames(xtrain) <- datacolnames
```


The subject and training type data are read and column names are added: 

```r
subject <- read.table("subject_train.txt")
colnames(subject) <- c("subject")

xtrain_id <- read.table("y_train.txt")
colnames(xtrain_id) <- c("traintype")
```


A column for data source is created and given column name: 

```r
xtrain_cv <- as.data.frame(matrix(rep("xtrain",nrow(xtrain)),ncol=1, nrow=nrow(xtrain)))
colnames(xtrain_cv) <- c("sourcetype")
```

A column for data source is created and given column name: 

```r
data1 <- cbind(xtrain_id, subject, xtrain_cv, xtrain)
```


The previous steps are repeated for test data:



```r
xtest <- read.table("X_test.txt")
colnames(xtest) <- datacolnames

subject <- read.table("subject_test.txt")
colnames(subject) <- c("subject")

xtest_id <- read.table("y_test.txt")
colnames(xtest_id) <- c("traintype")

xtest_cv <- as.data.frame(matrix(rep("xtest",nrow(xtest)),ncol=1, nrow=nrow(xtest)))
colnames(xtest_cv) <- c("sourcetype")

data2 <- cbind(xtest_id, subject, xtest_cv, xtest)
```


The training and test data are merged:



```r
data <- rbind(data1, data2)
```



Only basic identification data + mean & std deviation data are to be used in the new tidied data set:



```r
# selecting columns with basic data or means | std
tidied_ix <- c(1,2,3, grep("mean|std|Mean", colnames(data))  )
```


Create the tidied data set and writing it to file:


```r
tidydata <- data[tidied_ix]

write.table(tidydata,sep=",", file="tidydata.txt",row.name=FALSE)
```


# The code book

## Information about the variables (including units!) in the data set not contained in the tidy data


http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The source data and info is retrieved from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#



Merged / created fields:

 "traintype"    index for 1 WALKING2 WALKING_UPSTAIRS3 WALKING_DOWNSTAIRS4 SITTING5 STANDING6 LAYING

 "subject"      integer identifying the individual person, values 1 - 30
 
 "sourcetype"	Character string "train"/"test" indicating the sourcetype for the measurements.
 
 
 Original measurement fields: These are more or less self-describing names from the original data,
 which is " A 561-feature vector with time and frequency domain variables."
 
 The data chosen to use here is the ones which have "mean", "Mean" or "std" in their names.
  
 
 "tBodyAcc-mean()-X"
 "tBodyAcc-mean()-Y"
 "tBodyAcc-mean()-Z"
 "tBodyAcc-std()-X"
 "tBodyAcc-std()-Y"
 "tBodyAcc-std()-Z"
 "tGravityAcc-mean()-X"
 "tGravityAcc-mean()-Y"
 "tGravityAcc-mean()-Z"
 "tGravityAcc-std()-X"
 "tGravityAcc-std()-Y"
 "tGravityAcc-std()-Z"
 "tBodyAccJerk-mean()-X"
 "tBodyAccJerk-mean()-Y"
 "tBodyAccJerk-mean()-Z"
 "tBodyAccJerk-std()-X"
 "tBodyAccJerk-std()-Y"
 "tBodyAccJerk-std()-Z"
 "tBodyGyro-mean()-X"
 "tBodyGyro-mean()-Y"
 "tBodyGyro-mean()-Z"
 "tBodyGyro-std()-X"
 "tBodyGyro-std()-Y"
 "tBodyGyro-std()-Z"
 "tBodyGyroJerk-mean()-X"
 "tBodyGyroJerk-mean()-Y"
 "tBodyGyroJerk-mean()-Z"
 "tBodyGyroJerk-std()-X"
 "tBodyGyroJerk-std()-Y"
 "tBodyGyroJerk-std()-Z"
 "tBodyAccMag-mean()"
 "tBodyAccMag-std()"
 "tGravityAccMag-mean()"
 "tGravityAccMag-std()"
 "tBodyAccJerkMag-mean()"
 "tBodyAccJerkMag-std()"
 "tBodyGyroMag-mean()"
 "tBodyGyroMag-std()"
 "tBodyGyroJerkMag-mean()"
 "tBodyGyroJerkMag-std()"
 "fBodyAcc-mean()-X"
 "fBodyAcc-mean()-Y"
 "fBodyAcc-mean()-Z"
 "fBodyAcc-std()-X"
 "fBodyAcc-std()-Y"
 "fBodyAcc-std()-Z"
 "fBodyAcc-meanFreq()-X"
 "fBodyAcc-meanFreq()-Y"
 "fBodyAcc-meanFreq()-Z"
 "fBodyAccJerk-mean()-X"
 "fBodyAccJerk-mean()-Y"
 "fBodyAccJerk-mean()-Z"
 "fBodyAccJerk-std()-X"
 "fBodyAccJerk-std()-Y"
 "fBodyAccJerk-std()-Z"
 "fBodyAccJerk-meanFreq()-X"
 "fBodyAccJerk-meanFreq()-Y"
 "fBodyAccJerk-meanFreq()-Z"
 "fBodyGyro-mean()-X"
 "fBodyGyro-mean()-Y"
 "fBodyGyro-mean()-Z"
 "fBodyGyro-std()-X"
 "fBodyGyro-std()-Y"
 "fBodyGyro-std()-Z"
 "fBodyGyro-meanFreq()-X"
 "fBodyGyro-meanFreq()-Y"
 "fBodyGyro-meanFreq()-Z"
 "fBodyAccMag-mean()"
 "fBodyAccMag-std()"
 "fBodyAccMag-meanFreq()"
 "fBodyBodyAccJerkMag-mean()"
 "fBodyBodyAccJerkMag-std()"
 "fBodyBodyAccJerkMag-meanFreq()"
 "fBodyBodyGyroMag-mean()"
 "fBodyBodyGyroMag-std()"
 "fBodyBodyGyroMag-meanFreq()"
 "fBodyBodyGyroJerkMag-mean()"
 "fBodyBodyGyroJerkMag-std()"
 "fBodyBodyGyroJerkMag-meanFreq()"
 "angle(tBodyAccMean,gravity)"
 "angle(tBodyAccJerkMean),gravityMean)"
 "angle(tBodyGyroMean,gravityMean)"
 "angle(tBodyGyroJerkMean,gravityMean)"
 "angle(X,gravityMean)"
 "angle(Y,gravityMean)"
 "angle(Z,gravityMean)"




# Licence information:

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
