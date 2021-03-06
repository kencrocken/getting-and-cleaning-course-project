Course Project
===
##Getting and Cleaning Data
###Data Science, JHU coursera.org

As stated in the instructions for the course assignment:
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The requirements of the project are:

* Prepare a tidy data set as described below, 
* Link to a Github repository with your script for performing the analysis, and 
* Create a code book, called CodeBook.md, that describes the variables, the data, and any transformations or work that you performed to clean up the data. 
* Create a README.md in the repo with describing the scripts and how they are connected. 

The data set was provided by the professor and represents a set of observations regarding human activity recognition by use of smartphones.  Collected by Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita at the University of Genoa

>Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

For more information on the data please see the [code book](CodeBook.md).

In order to prepare the tidy data set, the project requires R script called run_analysis.R that does the following:
 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

To accomplish the project requirements we were create one R script called run_analysis.R.  

######Certain assumptions were made given the instructions provided for the project. The data set was already present in the users working directory. The script does not attempt to download the file or unzip the file. The script is written according to this assumption that the data set was already downloaded and unpacked into the working directory.

The following steps are performed by run_analysis.R:

* Read data set
  * Test Data, Activity & Subjects
  * Train Data, Activity & Subjects
* Read variable names
  * Subset to just names
  * Clean up column names
* Insert Column names into Test and Train DF
* Subset to required columns
* Combine the Test and Train DF
* Rename first two columns “subject” & activity
* Aggregate data by activity and subject and apply and take the mean of the variables
* Two extra columns are added with aggregate - remove those columns
* Provide descriptive names to the activity data
* Write table “course-project.txt” tab delimited data set

#####Read data set.
The project provided the data set for download on the course project page for the course.  For more information see the [code book](CodeBook.md).  

The test and train data are read into data frames, including the measurement data, activity data and subject data.  

6 data frames are made from this step as noted below.


```splus
testX <- read.table("UCI HAR Dataset/test/X_test.txt") # -- measurement data (561 variables)
testY <- read.table("UCI HAR Dataset/test/Y_test.txt") # -- activity data (one variable)
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt") # -- subject data (one variable)
trainX <- read.table("UCI HAR Dataset/train/X_train.txt") # -- measurement data (561 variables)
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt") # -- activity data (one variable)
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt") # -- subject data (one variable)
```
#####Read variable names - subset and cleanup.
The variable names are read into a data frame from the features.txt file.  An extra column of unneeded data (column numbers) is removed from the variable name data frame.

Variables in the original dataset were manipulated to appear more readable.  While there is apparent disagreement in standards for the variable names, e.g., some suggest not to use '.', some experts suggest the use of the '.'

######The main goal was to produce easily readable variable names that do not interfer with the manipulation of the data.  Please see the [code book](CodeBook.md) for more information regarding the conventions selected for naming the variables.

To that goal, I choose to use all lower case and '.' With some variable names being long, I find that using a '.' improves readability.  Please see the [code book](CodeBook.md) for more detail.


```splus
# --- Add column names, adjust for readability and standards;
# --- lower case and add .  
features <- read.table("UCI HAR Dataset/features.txt") # -- column numbers and names (two variables)
features <- features[,2] # -- subset to just the column names (one variable)
# Clean up the column names
features <- gsub("[[:punct:]]", "", features) # -- remove punct characters; e.g, (), _, -, etc ...
features <- gsub("fBodyBody","fBody",features) # -- replace "fBodyBody" with "fBody"
features <- gsub("X",".x",features) # -- add a . before 'X' for readability
features <- gsub("Y",".y",features) # -- add a . before 'Y' for readability
features <- gsub("Z",".z",features) # -- add a . before 'Z' for readability
features <- gsub("mean",".mean",features) # -- add a . before 'mean' for readability
features <- gsub("Mean",".mean",features)
features <- gsub(".meangravity","gravity",features)
features <- gsub("std",".std",features) # -- add a . before 'std' for readability
# lower case
features <- tolower(features)
```

#####Column names are inserted into the testX and trainX data frames.
The column names are inserted into the test and train data frames containing the measurement data.

```splus
# Insert column names
colnames(testX) <- features 
colnames(trainX) <- features
```
#####Subset to the data described in the course project.
The colums representing the mean and standard deviation for each measurement are selected, and the test and train data frames containing the measurement data are subsetted.
```splus
# --- Select on the columns representing the mean and std of each measurement,
# --- based on descriptions in UCI Features Info file
# Add variable to hold columns to be selected
columnSelection <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,
                     345:350,424:429,503:504,516:517,529:530,542:543,555:561)
# subset to required columns
testX <- testX[,columnSelection] 
trainX <- trainX[,columnSelection]
```
#####The data frames are combined.
The data frames contained the subject, activity and measurement data are combined to two data frames, testDF and train DF representing the test and training data.

The test and train data frames are then combined.
```splus
testDF <- cbind(testSubject,testY,testX)
trainDF <- cbind(trainSubject,trainY,trainX)
totalDF <- rbind(testDF,trainDF) # --- dataframe containing the total data set
```
#####Rename the first two columns of the totalDF.
```splus
colnames(totalDF)[1] <- "subject"
colnames(totalDF)[2] <- "activity"
```
#####Aggregate the data in totalDF by acitivty and subject - then take the mean of each variable.
The original data set used numbers to identify the various activities the subjects performed.  The numbers were replaced with descriptive names.

```splus
aggregatedDF$activity[aggregatedDF$activity == 1] <- "walking"
aggregatedDF$activity[aggregatedDF$activity == 2] <- "walking_upstairs"
aggregatedDF$activity[aggregatedDF$activity == 3] <- "walking_downstairs"
aggregatedDF$activity[aggregatedDF$activity == 4] <- "sitting"
aggregatedDF$activity[aggregatedDF$activity == 5] <- "standing"
aggregatedDF$activity[aggregatedDF$activity == 6] <- "laying"
```

#####Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
After cleaning the data, combining the data sets, enhancing the variable names and adding descriptive activity names a second data set was created by aggregating the data by subject and activity, and calculating the mean of each set of subject/activity pair sets.  Subset the aggregated data frame to remove columns added by the aggregate function.

```splus
aggregatedDF <- aggregate(totalDF, by=list(totalDF$activity,totalDF$subject), FUN=mean, na.rm=TRUE)
# --- Subset to remove the groups created by the aggregate function
aggregatedDF <- aggregatedDF[,c(3:77)]
```

#####Provide descriptive names to the activity labels
```splus
# --- Rename activity data: 1(walking),2(walking_upstairs,3(walking_downstairs),
#                           4(sitting),5(standing),6(laying)
aggregatedDF$activity[aggregatedDF$activity == 1] <- "walking"
aggregatedDF$activity[aggregatedDF$activity == 2] <- "walking_upstairs"
aggregatedDF$activity[aggregatedDF$activity == 3] <- "walking_downstairs"
aggregatedDF$activity[aggregatedDF$activity == 4] <- "sitting"
aggregatedDF$activity[aggregatedDF$activity == 5] <- "standing"
aggregatedDF$activity[aggregatedDF$activity == 6] <- "laying"
```
#####Write the aggregated data frame into a separate file.
Lastly the tidy data set of aggregated data is written as a tab delimited text file to the working directory.
```splus
write.table(aggregatedDF, "course-project.txt", sep="\t")
```

####Snapshot of the data.

![image](tidy-data-snapshot.png)
