---
title: "Course3Week3"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```



## Overview

The script `run_analysis.R` is for the assignment for course 3 week 4 of the gathering and cleaning data course. The goal of the assignment was to create a tidy data set. These where the questions:
1.     Merges the training and the test sets to create one data set.
2.     Extracts only the measurements on the mean and standard deviation for each measurement.
3.     Uses descriptive activity names to name the activities in the data set
4.     Appropriately labels the data set with descriptive variable names.
5.     From the data set in step 4, creates a second, independent tidy data set with the average of each  variable for each activity and each subject.

The final output data is called Meantidydata.txt


The library's used where:
`library(plyr)`
`library(dplyr)`
`library(reshape2)`

## Variables
xTrain, yTrain, TrainSub, xTest, yTest, and TestSub contain the data from the downloading files. The variiables with x as the prefect have the features data in them and y has the activity data. Sub has the subject data files. 

FeaturesXData, ActivityYData, SubData have the merged data. 

FullData have the full data set once merged together. 

means has the output data for the final question. 


