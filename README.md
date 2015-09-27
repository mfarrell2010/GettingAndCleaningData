# Getting and Cleaning Data Course Project

## Processing the UCI HAR Dataset

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

Included is
1. a tidy data, tidy_data.txt, set as described below 
2. a script, run_analysis.R, for performing the analysis
3. a code book, CodeBook.md, that describes the variables, the data, and the transformations that I performed to clean up the data called CodeBook.md. 
4. this README.md file

## run_analysis.R

This README.md explains how the script works and the required setup.  

The script should be modified to set the working directory to the directory you intend to work from. It will download the data set to that directory and work on the data there.

The script run_analysis.R that does the following. 
1. Uses descriptive activity names to name the activities in the data set
2. Appropriately labels the data set with descriptive variable names. 
3. Merges the training and the test sets to create one data set.
4. Extracts only the measurements on the mean and standard deviation for each measurement. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Processing steps
Here are the processing steps.

### Get the feature and activity lists
1. Download and unzip the data files.
2. Change the working directory to the datasets base directory, UCI HAR Dataset. Note: this step was done so I could develop the process against a smaller practice data set and later switch back.
3. Load the feature column names and create a data frame with just the measurements on the mean and standard deviation
4. Load and get the list of activity labels

### Merge the Test and Training Data Sets
Perform the following steps on the files in the test and train subdirectory to merge those files into a test and train data frame.
1. Load the subject file (subject_test, subject_train).
2. Load the y files (y_test, y_train) and create an actity factor data frame.
3. Merge the subject and activity data into a single data frame.
4. Load the x data files (x_test, x_train).
5. Subset the x data into a data set with just the mean and std columns.
6. Merge the subject-activity data frame and the new x data, data frame.

### Final Merge and Tidy Data Set Production
1. Merge the Test and Train data sets.
2. Create the Tidy data frame using ddply and a numColWise application of the mean function.
3. Write out the Tidy data frame to a text file.
