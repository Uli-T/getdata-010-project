# Getting and Cleaning Data : Course Project

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original data for the project can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Purpose of run_analysis.R

The script tidies the original dataset in the following ways: 
* It merges the training and the test sets to create one data set.
* It extracts only the measurements on the mean and standard deviation for each measurement. 
* It uses descriptive activity names to name the activities in the data set
* and appropriately labels the data set with descriptive variable names. 
* It creates an independent tidy data set with the average of each variable for each activity and each subject.

