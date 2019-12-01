# validating where my working directory is located
getwd()
# clearing global environment
rm(list = ls())

# utilize reshape2 package
install.packages("reshape2")
library(reshape2)

# download zip file containing data
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file containing data
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}


#reading features and activity data
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

#reading train data
train <- read.table("./UCI HAR Dataset/train/X_train.txt") #features data
colnames(train) <- features$V2 #descriptive column names for data (STEP 4)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt") #activity labels
train$activity <- y_train$V1
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt") #subjects
train$subject <- factor(subject_train$V1)


#reading test data
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test) <- features$V2
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt") 
test$activity <- y_test$V1
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test$subject <- factor(subject_test$V1)

#merge train and test sets (STEP 1)
dataset <- rbind(test, train) 

#filter column names (STEP 2)
column.names <- colnames(dataset)
#get only columns for standard deviation and mean values, also saves activity and subject values 
column.names.filtered <- grep("std\\(\\)|mean\\(\\)|activity|subject", column.names, value=TRUE)
dataset.filtered <- dataset[, column.names.filtered] 

#adding descriptive values for activity labels (STEP 3)
dataset.filtered$activitylabel <- factor(dataset.filtered$activity, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#creating a tidy dataset with mean values for each subject and activity
features.colnames = grep("std\\(\\)|mean\\(\\)", column.names, value=TRUE)
dataset.melt <-melt(dataset.filtered, id = c('activitylabel', 'subject'), measure.vars = features.colnames)
dataset.tidy <- dcast(dataset.melt, activitylabel + subject ~ variable, mean)

#creating a tidy dataset file  
write.table(dataset.tidy, "tidydataset.txt")

