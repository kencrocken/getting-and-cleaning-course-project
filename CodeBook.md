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

Accordingly, after examining the information provided in the UCI dataset, the following variables were determined to meet the criteria as measurements of mean and standard deviation based on the descriptions and variable name.

column| column name|
------|:-------------:|
1 | subject
2 |                         activity
3 |                   tbodyacc.mean.x
4 |                  tbodyacc.mean.y
5 |                  tbodyacc.mean.z
6 |                   tbodyacc.std.x
7 |                   tbodyacc.std.y
8 |                   tbodyacc.std.z
9 |               tgravityacc.mean.x
10|               tgravityacc.mean.y
11 |               tgravityacc.mean.z
12 |               tgravityacc.std.x
13 |               tgravityacc.std.y
14 |               tgravityacc.std.z
15 |              tbodyaccjerk.mean.x
16 |             tbodyaccjerk.mean.y
17 |              tbodyaccjerk.mean.z
18 |               tbodyaccjerk.std.x
19 |               tbodyaccjerk.std.y
20 |               tbodyaccjerk.std.z
21 |                 tbodygyro.mean.x
22 |                 tbodygyro.mean.y
23 |                 tbodygyro.mean.z
24 |                  tbodygyro.std.x
25 |                  tbodygyro.std.y
26 |                  tbodygyro.std.z
27 |             tbodygyrojerk.mean.x
28 |             tbodygyrojerk.mean.y
29 |             tbodygyrojerk.mean.z
30 |              tbodygyrojerk.std.x
31 |              tbodygyrojerk.std.y
32 |              tbodygyrojerk.std.z
33 |                 tbodyaccmag.mean
34 |                  tbodyaccmag.std
35 |              tgravityaccmag.mean
36 |               tgravityaccmag.std
37 |             tbodyaccjerkmag.mean
38 |              tbodyaccjerkmag.std
39 |                tbodygyromag.mean
40 |                 tbodygyromag.std
41 |            tbodygyrojerkmag.mean
42 |             tbodygyrojerkmag.std
43 |                  fbodyacc.mean.x
44 |                  fbodyacc.mean.y
45 |                  fbodyacc.mean.z
46 |                   fbodyacc.std.x
47 |                   fbodyacc.std.y
48 |                   fbodyacc.std.z
49 |              fbodyaccjerk.mean.x
50 |              fbodyaccjerk.mean.y
51 |              fbodyaccjerk.mean.z
52 |               fbodyaccjerk.std.x
53 |               fbodyaccjerk.std.y
54 |               fbodyaccjerk.std.z
55 |                 fbodygyro.mean.x
56 |                 fbodygyro.mean.y
57 |                 fbodygyro.mean.z
58 |                  fbodygyro.std.x
59 |                  fbodygyro.std.y
60 |                  fbodygyro.std.z
61 |                 fbodyaccmag.mean
62 |                  fbodyaccmag.std
63 |             fbodyaccjerkmag.mean
64 |              fbodyaccjerkmag.std
65 |                fbodygyromag.mean
66 |                 fbodygyromag.std
67 |            fbodygyrojerkmag.mean
68 |             fbodygyrojerkmag.std
69 |         angletbodyaccmeangravity
70 | angletbodyaccjerkmeangravitymean
71 |    angletbodygyromeangravitymean
72 |angletbodygyrojerkmeangravitymean
73 |               angle.xgravitymean
74 |               angle.ygravitymean
75 |               angle.zgravitymean
