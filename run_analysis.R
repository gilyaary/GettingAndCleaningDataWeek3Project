##Set the working directory to the root of the Week 3 project files
setwd("~/coursera_projects/R/Week3Project")

##read the x,y,subject files for the test data
x_test_df <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
y_test_df <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
subject_test_df <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")

##read the x,y,subject files for the train data
x_train_df <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
y_train_df <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
subject_train_df <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")

#Merge the respective test and train datasets
x_merged <- rbind(x_test_df, x_train_df)
y_merged <- rbind(y_test_df, y_train_df)
subject_merged <- rbind(subject_test_df, subject_train_df)

##read the feature file to get a dataframe containing the feature column number and respective description
features_df <- read.table(file = "UCI HAR Dataset/features.txt")

##use a regular expression to get the indexes of all means and standard deviation rows in the features file
reg_exp <- "-(mean|std)\\(\\)"
selected_column_indexes <- grep(pattern=reg_exp, x=features_df[,2]) 

##use the feature indexes to select only the required columns (mean and standard deviation)
x_merged_selected <- x_merged[,selected_column_indexes]

##assign the descriptive names to selected columns instead of the default names
names(x_merged_selected) <- features_df[selected_column_indexes,2]

##read the activity lables file
activity_lables_df <- read.table("UCI HAR Dataset/activity_labels.txt")

## set the activity description for each row. The activity lable is used as a row index in activity_lables_df
activity <- activity_lables_df[y_merged[,1],2]

# set the column name for the subject data
names(subject_merged) <- "Subject"

##add the activity and subject columns to the selected columns (mean and SD) 
merged_data <- cbind(activity,subject_merged,x_merged_selected)

##create average for all numeric columns, group by Subject and activity
averaged <- ddply( merged_data, .(Subject, activity), function(x) colMeans(x[, 3:68]) )

##write the data to a file
write.table(averaged, "averaged_by_activity_and_subject.txt", row.name=FALSE)
