# Getting and Cleaning Data assignment - Readme
---------------------------------------------

This dataset was prepared using a few assumptions:

- The 561 columns in the X datasets correspond to the 561 variables listed in the features.txt dataset
- The Y dataset identifies the activity conducted, and can be column bound to the X dataset
- The subject dataset identifies the subject # of the individual measured in each row.  This dataset can also be column bound to the X dataset
- The activity_labels.txt dataset is a lookup table which converts the the labels in the Y dataset into actual activity names
- The working directory for this script is "/Users/bhu235/Documents/Getting-Cleaning-Data_assignment.git/"

The full tidy data set contains 10,299 records (describing subject, activity, and recording) and 68 columns (subject, activity, and measurements).  The data is exported as "full data set.txt".

The exported aggregate data set (labeled "aggregated output.txt") contains 180 records (6 activities * 30 subjects) and 68 columns (activity, subject, and measurements).

run_analysis.R script contains all the neccessary code required to download, extract, & process the original data set.  It outputs both the "full data set.txt" and "aggregated output.txt" data sets as described above.

CodeBook.md contains a detailed description of how the data is acquired, processed, and output.  It also describes the data sets generated by the script.