######### Build the full tidy data set ############

## Download and extract data sets
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,destfile="/Users/bhu235/Documents/Getting-Cleaning-Data_assignment.git/zipped_dataset.zip",method="curl")
unzip("zipped_dataset.zip")
rm(fileURL)

## Import features set, convert to vector
features <- read.table(paste(getwd(),"/UCI HAR Dataset/features.txt",sep=""),sep=" ",stringsAsFactors=FALSE)
featureVector <- features$V2
rm(features)

## Identify which feature contain mean or std, builds import vector
containsMean <- as.vector(sapply(FUN=regexpr,pattern="mean()",X=featureVector,fixed=TRUE))
containsStd <- as.vector(sapply(FUN=regexpr,pattern="std()",X=featureVector,fixed=TRUE))
containsMean <- containsMean*abs((1/containsMean))
containsStd <- containsStd*abs((1/containsStd))
containsEither <- ((containsMean >0) + (containsStd >0 )) > 0
rm(containsMean,containsStd)
importVector <- (as.integer(containsEither)*32)-16

## import and nameactivity list
activityLabels <-read.table(paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep=""),sep=" ",stringsAsFactors=FALSE)
names(activityLabels) <- c("labelNumber","activity")

## Import X, Y, & subject for training and testing data
XTrain <- read.fwf(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt",sep=""),importVector)
YTrain <- read.table(paste(getwd(),"/UCI HAR Dataset/train/y_train.txt",sep=""))
subjectTrain <- read.table(paste(getwd(),"/UCI HAR Dataset/train/subject_train.txt",sep=""))
XTest <- read.fwf(paste(getwd(),"/UCI HAR Dataset/Test/X_Test.txt",sep=""),importVector)
YTest <- read.table(paste(getwd(),"/UCI HAR Dataset/Test/y_Test.txt",sep=""))
subjectTest <- read.table(paste(getwd(),"/UCI HAR Dataset/Test/subject_test.txt",sep=""))
rm(importVector)

## Stack Train and Test Sets
fullData <- rbind(XTrain,XTest)
Y <- rbind(YTrain,YTest)
names(Y) <- "labelNumber"
Subject <- rbind(subjectTrain,subjectTest)
rm(XTrain,YTrain,XTest,YTest,subjectTrain,subjectTest)

## Merge activity onto Y set
library(plyr)
Y <- join(Y,activityLabels)
rm(activityLabels)

## Rename X variables 
names(fullData) <- featureVector[containsEither]
rm(featureVector,containsEither)

## Merge X and Y
fullData$activity <- Y$activity
fullData$subject <- Subject$V1
rm(Y,Subject)

## Prints full data set
write.table(fullData,file="full data set.txt",quote=FALSE,sep=",",col.names=TRUE,row.names=FALSE)

######### Build the dataset reduced to 1 record per subject & acvtivity ############

## install & load reshape package (used for melting and recasting described below)
library(reshape2)

## Melt fullData frame
colNames <- names(fullData)
fullMelt <- melt(fullData,id=colNames[67:68],measure.vars=colNames[1:66])

## Recast melted data into new form (1 row per subject/activity combination)
outputData <- dcast(fullMelt,subject+activity ~ variable,mean)
rm(fullMelt,colNames)

## Prints the outputData table to a CSV file
write.table(outputData,file="aggregated output.txt",quote=FALSE,sep=",",col.names=TRUE,row.names=FALSE)