# CODE BOOK


### Description
This documents contains an step by step infomation about tidy data set. It gives an introduction how the original dataset has been modified to make it as tidy dataset.

### Origin of data source
A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### About original data set
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
Every recored has contained following information
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Task performed 

### Task 1. Merge the training and the test sets to create one data set.
The given .txt file has been read into tables and assign as an individul object

features     = features.txt
activityType = activity_labels.txt
subjectTrain = train/subject_train.txt
xTrain       = train/x_train.txt
yTrain       = train/y_train.txt

The new column names has been assigned and merged to create one data set. The data set has been combined as training data and test data. 
At this level a vector has been declear for testing in next step

## Task 2. Extract only the measurements on the mean and standard deviation for each measurement. 
The Subsetting fucntion useful for keep only the necessary columns.
- Only TRUE values for the ID, mean and stdev columns 
- Only FALSE values for the ID, mean and stdev columns 

## Task 3. Use descriptive activity names to name the activities in the data set
The data has to merged with the merged with subset and assiged new descriptive activity names

## Section 4. Appropriately label the data set with descriptive activity names.
The data cleaning has been performed for making meaning-full labels.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
A tidy dataset  has been created for this assigement and imported as per given instructions by the instructor
