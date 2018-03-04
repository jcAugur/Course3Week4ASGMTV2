

#Create the dir. and download the file.

#load libraries
library(plyr)
library(dplyr)
library(reshape2)


#create dri
setwd("D:/Documents-Big/R DataScience/Course 3/week4")
if(!file.exists("Course3WkData")){
  dir.create("Course3WkData")
}
setwd("Course3WkData")

#download the data
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Data.zip", mode = "wb")
unzip(zipfile="Data.zip")


#Load the data and look the dproperties of the data which was loaded. 
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
TrainSub <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
str(xTrain)
str(yTrain)
str(TrainSub)

xTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
TestSub <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
str(xTrain)
str(xTrain)
str(xTrain)

# Merges the training and the test sets to create one data set.
#three sets to be merged

# x data merge
FeaturesXData <- rbind(xTrain, xTest)

#  y data merge
ActivityYData <- rbind(yTrain, yTest)

#  subject data merge
SubData <- rbind(TrainSub, TestSub)

#competed section one of merging the data sets.

names(SubData)<-c("Subject") #change the column name to a meaningful one. 
names(ActivityYData)<- c("ActivityCode") #change the column name to a meaningful one. 
features <- read.table("UCI HAR Dataset/features.txt",head=FALSE) #get the column names for the feture datas
names(FeaturesXData)<- features$V2 #the names are stored in the second column. 

FullDataStep1<-cbind(SubData, ActivityYData) 
FullData <- cbind(FeaturesXData, FullDataStep1)
rm(FullDataStep1)
str(FullData)

#Extracts only the measurements on the mean and standard deviation for each measurement
ColNamesWithMeanAndStd<-names(FullData)[grep("mean\\(\\)|std\\(\\)", names(FullData))]
ColTobekept<-c(as.character(ColNamesWithMeanAndStd), "Subject", "ActivityCode" )
FullData<-subset(FullData,select=ColTobekept)

#Uses descriptive activity names to name the activities in the data set
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",head=FALSE) #get lebles 
ActivityLabels <- rename(ActivityLabels, ActivityCode = V1, Activity = V2)
FullData <- merge(FullData, ActivityLabels, by.x = "ActivityCode", by.y = "ActivityCode")
FullData <- select(FullData, -ActivityCode)

#Appropriately labels the data set with descriptive variable names.
#Write 
names(FullData) <- sub("^t", "TimeSignal", names(FullData))
names(FullData) <- sub("^f", "frequency", names(FullData))
names(FullData) <-sub("mean", "Mean", names(FullData))
names(FullData) <-sub("std", "StandardDeviation", names(FullData))
names(FullData) <-sub("max", "Maximum", names(FullData))
names(FullData) <-sub("min", "Minimum", names(FullData))
names(FullData) <-sub("Mag", "Magnitude", names(FullData))
names(FullData) <-sub("X", "Xaxis", names(FullData))
names(FullData) <-sub("Y", "Yaxis", names(FullData))
names(FullData) <-sub("Z", "Zaxis", names(FullData))
names(FullData) <-sub("\\()", "", names(FullData))
names(FullData) <-gsub("-", "", names(FullData))
names(FullData) <-sub("Acc", "Acceleration", names(FullData))
names(FullData) <-sub("Gyro", "Gyroscope", names(FullData))
names(FullData) <-sub("BodyBody", "Body", names(FullData))


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
ActivitySubjectMeltFullData <- melt(FullData, id=c("Activity", "Subject"))
means<-dcast(ActivitySubjectMeltFullData , Subject + Activity ~ variable, mean)
write.table(means, "Meantidydata.txt", row.names = FALSE)

