######Getting and Cleaning DataData Science, JHU coursera.org
#####Course Project
##Code Book
===
The data set was provided by the course instructors and consists data collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description of the data can be found at [UCI Machine Learning Repository, 
Human Activity Recognition Using Smartphones Data Set ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

From UCI, the data set describes:
>... experiments [that] have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

Further UCI provides the following information for each record in the dataset:

* Triaxial Acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

The data set was provided as a zipped file and the instructions were to unzip the file into the working directory of RStudio - such that a script will assume the appropriate files are in the working directory.

For the purposes of this project the Triaxial Acceleration and Triaxial Angular were not needed - such data was contained in the Inertial Signals directories of the data set.

The assumed file structure of the data set is as follows:
```
/Working Directory
└──UCI HAR Dataset
	├── README.txt
	├── activity_labels.txt
	├── features.txt
	├── features_info.txt
	├── test
	│   ├── Inertial Signals (**NOT NEEDED**)
	│   ├── X_test.txt
	│   ├── subject_test.txt
	│   └── y_test.txt
	└── train
	    ├── Inertial Signals(**NOT NEEDED**)
	    ├── X_train.txt
	    ├── subject_train.txt
	    └── y_train.txt
```
The above files are described as follows:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

For the purposes of this project we were to merge the test and train data sets,
extract only the measurements on the mean and standard deviation for each measurement, 
modify the variable names for readability and tidiness, modify the activity labels to be descriptive.
