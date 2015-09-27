# File: run_analysis.R
# Purpose: This script does the following. 
#     1) Merges the training and the test sets to create one data set.
#     2) Extracts only the measurements on the mean and standard deviation for each measurement. 
#     3) Uses descriptive activity names to name the activities in the data set
#     4) Appropriately labels the data set with descriptive variable names. 
#     5) From the data set in step 4, creates a second, independent tidy data, tidy_data.txt,
#        that with the average of each variable for each activity and each subject.

# Load required packages
require("data.table")
require("plyr")

# Set the working directory
setwd('c:/code/r/GettingAndCleaningData')

# Download the UCI HAR dataset and unzip it
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./UCI_HAR_Dataset.zip")
unzip("./UCI_HAR_Dataset.zip")

# Change directory into the data set
setwd('c:/code/r/GettingAndCleaningData/short')
setwd('c:/code/r/GettingAndCleaningData/UCI HAR Dataset')

# Load the feature column names
features <- read.csv("features.txt", sep=" ", header=FALSE, 
                     col.names=c("id","colname"))
# Select only the measurements on the mean and standard deviation for each measurement. 
mean_list <- grep("-mean",features$colname)
std_list <- grep("-std",features$colname)
mean_std_list <- c(mean_list,std_list)
mean_std_col <- features$colname[mean_std_list]
col_list <- data.frame(mean_std_list, mean_std_col,  stringsAsFactors = FALSE)
col_list$mean_std_col <- gsub("\\(","", col_list$mean_std_col)
col_list$mean_std_col <- gsub("\\)","", col_list$mean_std_col)
# Get an ordered vector of these column numbers
col_list <- col_list[order(col_list$mean_std_list),]
# Write out the columns for use in the Code Book.
write.csv(col_list, "col_list.csv")

# Read in the activity labels
activity_labels <- read.csv("activity_labels.txt",sep=" ",header=FALSE)
activity <- activity_labels[,2]

################################
# Merging together the Test data
# Load the subject data
subject_test <- read.table("test/subject_test.txt")

# Load the activity data
y_test <- read.table("test/y_test.txt")
names(y_test) = c('act_id')
# Completes Requirement 3: uses descriptive activity names to name the activities in the data set
act_test <- factor(y_test$act_id, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS"," SITTING","STANDING","LAYING"))
# act_test <- data.frame(factor(y_test$act_id, labels=c("STANDING")))
# Merge subject and activities (y_test)
front <- data.frame(subject_test, act_test)
names(front) <-  c("subject", "activity")

# Load x_test and filter out the mean and std columns
x_test <- read.table("test/X_test.txt")
# Completion of Requirement 2: Extracting only the measurements on the mean and stad dev
x_test <- x_test[,col_list$mean_std_list]
# Completes Requirement 4: appropriately labels the data set with descriptive variable names
names(x_test) <- col_list$mean_std_col
# Merging subject-activity with the mean and std data columns
df_test <- cbind(front, x_test)


################################
# Merging together the Train data
# Load the subject data
subject_train <- read.table("train/subject_train.txt")

# Load the activity data
y_train <- read.table("train/y_train.txt")
names(y_train) = c('act_id')
act_train <- factor(y_train$act_id, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS"," SITTING","STANDING","LAYING"))
# act_train <- data.frame(factor(y_train$act_id, labels=c("STANDING")))
# Merge subject and activities (y_test)
front <- data.frame(subject_train, act_train)
names(front) <-  c("subject", "activity")

# Load x_test and filter out the mean and std columns
x_train <- read.table("train/X_train.txt")
x_train <- x_train[,col_list$mean_std_list]
names(x_train) <- col_list$mean_std_col
# Merging subject-activity with the mean and std data columns
df_train <- cbind(front, x_train)

# Merge the Test and Train data sets
# Completion of Requirement 1: merging the training and the test sets to create one data set
df <- rbind(df_test, df_train)

# Completion of Requirement 5: the independent tidy data
tidy_data <- ddply(df, .(subject, activity), numcolwise(mean))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
