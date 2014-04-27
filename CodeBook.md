# Getting and Cleaning Data assignment - CodeBook
---------------------------------------------

This dataset was prepared using the datasets provided at:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is derived from a study analyzing the accelerometer and gyro outputs from 30 subjects carrying out 6 activities.  The first data set contains 1 row per subject, activity, and recording instance. The second reduces the rows to 1 row per subject/activity by taking the mean of the each measurement for the given subject/activity combination.  Measurements are limited only to those which describe the mean or standard deviation of a measurement.

To prepare the first data set (full data set, labeled "full data set.txt"):
1. The compressed data set was downloaded and extracted
2. The feature.txt file, which contains the column labels of the X files, was imported
3. The features containing "mean" and "std" were identified in a separate logical vector (containsEither)
4. An import vector (importVector) was created from containsEither, which identifies which columns should be imported using the fixed width file format.  Entry of 16 indicates importing a column of 16 characters, entry of -16 indicates to skip the next 16 characters
5. The activity_labels.txt file was imported and columns labelled appropriately
6. The X, Y, and subject datasets were imported from both the train and test folders
7. The train and test datsets were stacked using rbind, reducing to a single X (fullData), Y, and Subject dataset
8. The activity numbers in the Y dataset were merged with the activity labels in activityLabels using the join function in the plyr package
9. The fullData dataset column names were renamed using the corresponding labels from featureVector.  featureVector was subsetted to only the columns imported in step 6
10. The activity labels from Y and the subject labels from subjectLabels were added to the fullData dataset
11. fulLData is printed to a CSV labeled "full data set.txt".  column names are kept in the first row, row names are omitted, and the data is separated with commas.

All other objects other than fullData were removed from the environment.  The resulting dataset contains 10,299 records and 68 columns.  66 columns identify types of measurements, the Subject column identifies the subject # of the participant, and the activity column identifies the activity carried out by the that subject in the specific record.

to prepare the second data set (labeled "aggregated output.txt"):

1. The reshape2 package is loaded for melting and casting
2. The fullData frame is melted.  ID fields are subject and activity.  all other fields are measurement variables.
3. The melted data is recast by generating the mean of all measurement variables along both id variables (subject and activity).  The resulting table is stored in outputData
4. outputData is printed to a CSV labeled "output Data.txt".  column names are kept in the first row, row names are omitted, and the data is separated with commas.

All other objects other than fullData and outputData were removed from the environment.  The resulting dataset contains 180 records and 68 columns.  66 columns identify types of measurements, the Subject column identifies the subject # of the participant, and the activity column identifies the activity carried out by the that subject in the specific record.  The measurement values are the mean of the recordings for that measurement, subject, and activity combination.