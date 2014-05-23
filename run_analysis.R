# --- Read data into tables
testX <- read.table("UCI HAR Dataset/test/X_test.txt") # -- measurement data (561 variables)
testY <- read.table("UCI HAR Dataset/test/Y_test.txt") # -- activity data (one variable)
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt") # -- subject data (one variable)
trainX <- read.table("UCI HAR Dataset/train/X_train.txt") # -- measurement data (561 variables)
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt") # -- activity data (one variable)
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt") # -- subject data (one variable)

# --- Add column names, adjust for readability and standards;
# --- opted to retain camel case and add .  
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
# Insert column names
colnames(testX) <- features 
colnames(trainX) <- features

# --- Select on the columns representing the mean and std of each measurement,
# --- based on descriptions in UCI Features Info file
# Add variable to hold columns to be selected
columnSelection <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,
                     345:350,424:429,503:504,516:517,529:530,542:543,555:561)
# subset to required columns
testX <- testX[,columnSelection] 
trainX <- trainX[,columnSelection]

# --- Bind the dataframes for the test set and train set; subject, activity and data
testDF <- cbind(testSubject,testY,testX)
trainDF <- cbind(trainSubject,trainY,trainX)
totalDF <- rbind(testDF,trainDF) # --- dataframe containing the total data set

# --- Rename the first two columns to subject and activity
colnames(totalDF)[1] <- "subject"
colnames(totalDF)[2] <- "activity"

# --- Aggregate the data based on the activity and subject, taking the mean of the columns
aggregatedDF <- aggregate(totalDF, by=list(totalDF$activity,totalDF$subject), FUN=mean, na.rm=TRUE)

# --- Subset to remove the groups created by the aggregate function
aggregatedDF <- aggregatedDF[,c(3:77)]

# --- Rename activity data: 1(walking),2(walking_upstairs,3(walking_downstairs),
#                           4(sitting),5(standing),6(laying)
aggregatedDF$activity[aggregatedDF$activity == 1] <- "walking"
aggregatedDF$activity[aggregatedDF$activity == 2] <- "walking_upstairs"
aggregatedDF$activity[aggregatedDF$activity == 3] <- "walking_downstairs"
aggregatedDF$activity[aggregatedDF$activity == 4] <- "sitting"
aggregatedDF$activity[aggregatedDF$activity == 5] <- "standing"
aggregatedDF$activity[aggregatedDF$activity == 6] <- "laying"

# --- write tab delimited text file
write.table(aggregatedDF, "course-project.txt", sep="\t")