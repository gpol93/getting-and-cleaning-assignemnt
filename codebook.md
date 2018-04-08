# Code Book
It describes the process for the assignment of week4

# About source data
The data that was used to work was Human Activity Recognition Using Smartphones Data Set.
You can find a descirpiton here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
And the data here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# R script
The file RUN_ANALYSIS.R enables to get the final output tidySet.txt by following the  steps desribed hereabove :

1.Merging the training and the test sets in one data set.
 Reading files
    Reading trainings tables
    Reading testing tables
    Reading feature vector
    Reading activity labels
    Assigning column names
    Merging all data in one set
2.Extracting only the measurements on the mean and standard deviation for each measurement
 Reading column names
 Create vector for defining ID, mean and standard deviation
 Making nessesary subset from setAllInOne
3.Using descriptive activity names to name the activities in the data set
4.Appropriately labeling the data set with descriptive variable names
5.Creating a second, independent tidy data set with the average of each variable for each activity and each subject
 Making second tidy data set
 Writing second tidy data set in txt file

About variables:
•x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
•x_data, y_data and subject_data merge the previous datasets to further analysis.
•features contains the correct names for the x_data dataset, which are applied to the column names stored in
