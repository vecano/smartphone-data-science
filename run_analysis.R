################################################################################
## 1. Merges the training and the test sets to create one data set.
test_data <- read.table('UCI\ HAR\ Dataset/test/X_test.txt')
test_subjects <- read.table('UCI\ HAR\ Dataset/test/subject_test.txt')
test_activities <- read.table('UCI\ HAR\ Dataset/test/y_test.txt')
test_set <- cbind(test_subjects, test_activities, test_data)

train_data <- read.table('UCI\ HAR\ Dataset/train/X_train.txt')
train_subjects <- read.table('UCI\ HAR\ Dataset/train/subject_train.txt')
train_activities <- read.table('UCI\ HAR\ Dataset/train/y_train.txt')
train_set <- cbind(train_subjects, train_activities, train_data)

df_set <- rbind(test_set, train_set)

################################################################################
## 4. Appropriately labels the data set with descriptive variable names.
measurements <- read.table('UCI\ HAR\ Dataset/features.txt', colClasses=c("NULL", "character"))
measurements_labels <- as.vector(measurements[,1])
col_labels <- c(c("Subject", "Activity"), measurements_labels)
colnames(df_set) <- col_labels   ## Set column names

################################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## Remove all except measurement columns except those with "mean" or "std" on their name
keep_columns <- c(col_labels[grep("mean", col_labels)], col_labels[grep("std", col_labels)])
df_set <- df_set[,c("Subject", "Activity", keep_columns)]

################################################################################
## 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table('UCI\ HAR\ Dataset/activity_labels.txt')
for(i in 1:nrow(activities)) {
     df_set$Activity[df_set$Activity==activities[i,1]] <- as.character(activities[i,2])
}

####################################################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of
## each variable for each activity and each subject.
df_set_melt <- melt(df_set, id=c("Subject", "Activity"), measure.vars=keep_columns)
averages <- dcast(df_set_melt, Subject + Activity ~ variable, mean)
