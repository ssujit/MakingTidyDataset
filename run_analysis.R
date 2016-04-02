# Assignment: Getting and Cleaning Data Course Project
# Author: S.Sujit


# setting working directory
setwd("D:/Datascience/CleaningData/Week4/UCI HAR Dataset")

# data has to be downloaded from a given source by Coursera instructor and unzipped
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# check and Clean up workspace
dir()

## Task 1. Merge the training and the test sets to create one data set.

# Read in the data from files to import them under individual objects
features     = read.table('./features.txt',header = FALSE);
activityType = read.table('./activity_labels.txt',header = FALSE);
subjectTrain = read.table('./train/subject_train.txt',header = FALSE);
xTrain       = read.table('./train/x_train.txt',header = FALSE);
yTrain       = read.table('./train/y_train.txt',header = FALSE);

# Giving column names (head) to the data imported during task 1
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2];
colnames(yTrain)        = "activityId";

# Create the final training set by merging yTrain, subjectTrain, and xTrain

trainingData = cbind(yTrain,subjectTrain,xTrain);

# Read in the test data and import
subjectTest = read.table('./test/subject_test.txt',header = FALSE);
xTest       = read.table('./test/x_test.txt',header = FALSE);
yTest       = read.table('./test/y_test.txt',header = FALSE);

# Giving column names to the test data imported above
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2];
colnames(yTest)       = "activityId";


# Create the final test set after merging
testData = cbind(yTest,subjectTest,xTest);


# Create a final data set after combining training and test data to
finalData = rbind(trainingData,testData);

# Create a vector for the column names and use to select the desired mean() & stddev()
colNames  = colnames(finalData);

## Task 2. Extract only the measurements on the mean and SD for each measurement.

# Create a logicalVector that contains TRUE values for the ID, mean() & stddev() columns and FALSE for others
logicalVector = (
  grepl("activity..",colNames) |
    grepl("subject..",colNames) |
    grepl("-mean..",colNames) &
    !grepl("-meanFreq..",colNames) &
    !grepl("mean..-",colNames) |
    grepl("-std..",colNames) & !grepl("-std()..-",colNames)
);

# Subset datatable and keep only desired columns
finalData = finalData[logicalVector == TRUE];

## Task 3. Uses descriptive activity names to name the activities in the data set

finalData = merge(finalData,activityType,by = 'activityId',all.x = TRUE); # Merge the dataset and give descriptive activity names

colNames  = colnames(finalData); # Give a new column names after merge

# Task 4. Appropriately label the data set with descriptive activity names.

# Clean all the variable names
for (i in 1:length(colNames))
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

# Assign a new descriptive column names to the finalData set
colnames(finalData) = colNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

# Create a new table after removing activityType column
finalDataNoActivityType = finalData[,names(finalData) != 'activityType'];

# Summarizing only with the mean of each variable, activity, subject
tidyData = aggregate(
  finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by =
    list(
      activityId = finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId
    ),mean
);

# Merging the tidyData with activityType to include descriptive acitvity names
tidyData = merge(tidyData,activityType,by = 'activityId',all.x = TRUE);

# Finally the data set has to be Exported as tidyData set
write.table(tidyData,'./tidyData.txt',row.names = TRUE,sep = '\t');

