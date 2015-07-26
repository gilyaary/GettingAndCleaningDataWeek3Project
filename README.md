## Coursera: Getting and cleaning Data
## Coursera Week 3 Project 

##run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Processing steps
1. Set the working directory to the root of the Week 3 project files
2. read the x,y,subject files for the test data
3. read the x,y,subject files for the train data
4. Merge the respective test and train datasets
5.read the feature file to get a dataframe containing the feature column number and respective description
features_df <- read.table(file = "UCI HAR Dataset/features.txt")
6. use a regular expression to get the indexes of all means and standard deviation rows in the features file (using the grep function)
7. use the feature indexes to select only the required columns (mean and standard deviation)
8. assign the descriptive names to selected columns instead of the default names
9. read the activity lables file
10. set the activity description for each row. The activity lable is used as a row index in activity_lables_df
11.set the column name for the subject data
12. add the activity and subject columns to the selected columns (mean and SD) 
13. create average for all numeric columns, group by Subject and activity
14. write the tidy data to a file: "averaged_by_activity_and_subject.txt"
