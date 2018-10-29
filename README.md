# Getting and Cleaning Data Course Project
## README
## Author: Jack Lee

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The goal is to prepare tidy data that can be used for later analysis.

This is how the script works:

1. Install the "reshape2" packages if not loaded yet
2. download the zip file from the website address and unzip it
3. Merges the training and the test sets to create one data set.
	* Merge the data from training and test data and assgn column names
	* Merge the activities from training and test data and assign column names
	* Merge the subject from training and test data and assign column name
	* Merge three dataframe together to form the AllData
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. Uses descriptive activity names to name the activities in the data set
6. Appropriately labels the data set with descriptive variable names.
7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

