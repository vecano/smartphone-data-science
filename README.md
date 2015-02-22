# Smartphone Accelerometer Data Analysis

The code in this project (`run_analysis.R`) calculates the data averages from
the sensor signals (accelerometer and gyroscope) collected by smartphones for
the ["Human Activity Recognition Using Smartphones Data Set" experiment]
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


## Running the Code

The data for this experiment can be obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Download and unzip the above zip file into the same directory as this repository
alongside the `run_analysis.R` file. The contents should expand into the "UCI HAR
Dataset" directory which contains the information collected from the
smartphones experiment.

The code can be run from within R by typing:

    > source('run_analysis.R')
    > write.table(averages, "tidy-data.txt", row.names = FALSE)

The last command creates a tidy data file in the current directory with the
average values for the mean and standard deviations of the measurements
collected by the experiment.


## Summary

`run_analysis.R` works by creating data frames for the two types of data in the
experiment (the training data set and the test data set). It enhances these two
data frames by adding the related subject and activity type from the
`subject_train.txt` and `y_train.txt` files (similar files for the test data).

These two data frames are merged together and column names are added by using
the information from `features.txt`.

Then, the 6 activity keys are replaced by descriptive activity names from the
information in `activity_labels.txt`.

Finally, the averages of the measurement columns are calculated for each
independent activity and subject.
