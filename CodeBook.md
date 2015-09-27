# Code Book

This code book describes the data used in this project, as well as the processing required to create the resulting tidy data set.

## Overview

30 volunteers performed 6 different activities while wearing a smartphone. The smartphone captured various data about their movements.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the README.txt file for further details about this dataset. 

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link]

An updated version of this dataset can be found at [Web Link]. It includes labels of postural transitions between activities and also the full raw inertial signals instead of the ones pre-processed into windows.


Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Description Input Files

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

*- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

* 'test/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Description Output File

* 'tidy_data.txt': record with the average of each variable for each activity and each subject.

## Processing steps

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
