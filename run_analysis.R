
## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
## One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
## Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
## The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
## A full description is available at the site where the data was obtained:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## Here are the data for the project:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## The goal is to prepare tidy data that can be used for later analysis.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Cleaningdataproject <- function () {

	## install the needed packages if not loaded yet
	if(!library(reshape2, logical.return = TRUE)) {
 	 install.packages('reshape2')
 	 library(reshape2)
	}


	## download the data files
	if(!file.exists("./data")) {dir.create("./data")}
	fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download.file(fileUrl,destfile="./data/data.zip")
	unzip("./data/data.zip", exdir = "./data")
	
## 1. Merges the training and the test sets to create one data set.
	## read the data
	datafilepath <- "./data/UCI HAR Dataset"
	TrainData <- read.table(file.path(datafilepath,"train/X_train.txt"),header = FALSE)
	TestData <- read.table(file.path(datafilepath,"test/X_test.txt"),header = FALSE)
	CombData <- rbind(TrainData,TestData)
	## Assign the column names to the data
	Features <- read.table(file.path(datafilepath,"features.txt"),header = FALSE)
	colnames(CombData) <- Features[,2]

	## read the activities
	TrainAct <- read.table(file.path(datafilepath,"train/y_train.txt"),header = FALSE)
	TestAct <- read.table(file.path(datafilepath,"test/y_test.txt"),header = FALSE)
	CombAct <- rbind(TrainAct,TestAct)
	## Assigne the column name to Activity
	colnames(CombAct) <- "Activities"
	
	## read the subject
	TrainSub <- read.table(file.path(datafilepath,"train/subject_train.txt"),header = FALSE)
	TestSub <- read.table(file.path(datafilepath,"test/subject_test.txt"),header = FALSE)
	CombSub <- rbind(TrainSub,TestSub)
	## Assigne the column name to Subject
	colnames(CombSub) <- "Subject"

	## Merge all data
	AllData <- cbind(CombSub,CombAct,CombData)





## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	RequiredColumns <- c(1,2,grep("mean\\(\\)|std\\(\\)",names(AllData),ignore.case = TRUE))
	CleanedData <- AllData[,RequiredColumns]

## 3. Uses descriptive activity names to name the activities in the data set
	## read the activity
	Activities <- read.table(file.path(datafilepath,"activity_labels.txt"),header = FALSE)
	CleanedData$Activities <- Activities[CleanedData$Activities,2]
	
## 4. Appropriately labels the data set with descriptive variable names.
	## replace t with Time
	names(CleanedData) <- sub("^t","Time",names(CleanedData))
	## replacing f with Frequency
	names(CleanedData) <- sub("^f","Frequency",names(CleanedData))

	names(CleanedData) <- sub("mean\\(\\)","Mean",names(CleanedData))
	names(CleanedData) <- sub("std\\(\\)","SD",names(CleanedData))
	names(CleanedData) <- sub("Acc","Accelerometer",names(CleanedData))
	names(CleanedData) <- sub("Mag","Magnitude",names(CleanedData))
	names(CleanedData) <- sub("Gyro","Gyroscope",names(CleanedData))
	names(CleanedData) <- sub("BodyBody","Body",names(CleanedData))


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

	MeltedData <- melt(CleanedData, id = c("Subject","Activities"))
	tidyData <- dcast(MeltedData, Subject + Activities ~ variable, mean)
	write.table(tidyData,file=file.path("./data/tidy.txt"),row.name=FALSE)


	
}