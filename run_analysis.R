##download file

## download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "GCD_project_data.zip", mode = "wb")

## unzip the data
unzip("GCD_project_data.zip", overwrite = T)

## read test data
x_test <- read.delim("./UCI HAR Dataset/test/X_test.txt", sep="" , header=F)
y_test <- read.delim("./UCI HAR Dataset/test/y_test.txt", sep="" , header=F)
subject_test <- read.delim("./UCI HAR Dataset/test/subject_test.txt", sep="" , header=F)

## merge test data into one data frame
test_data <- cbind(subject_test,y_test,x_test)

## read train data
x_train <- read.delim("./UCI HAR Dataset/train/X_train.txt", sep="" , header=F)
y_train <- read.delim("./UCI HAR Dataset/train/y_train.txt", sep="" , header=F)
subject_train <- read.delim("./UCI HAR Dataset/train/subject_train.txt", sep="" , header=F)

## merge train data into one data frame
train_data <- cbind(subject_train,y_train,x_train)

## create labels for the dataset
features <- read.delim("./UCI HAR Dataset/features.txt", sep = "", header = F)
labels <- c("subject","activity_id", as.character(features[[2]]))

## Assign the labels to the data sets
names(test_data) <- labels
names(train_data) <- labels


## merge train and test data sets
combined_data <- rbind(test_data, train_data)

## to determine which columns to include, grep for mean or std in the columns
mean_std_columns <- grep("mean|std",labels,ignore.case = T)

## subset the combined data frame using the mean_std_columns. 
## Include the subject and activity columns
mean_std_data <- combined_data[,c(1,2,mean_std_columns)]


## read in the activity labels. rename columns (this will help with merge activity thereafter)
activity_labels <- read.delim("./UCI HAR Dataset/activity_labels.txt", sep="" , header=F)
names(activity_labels) <- c("activity_id", "activity")

## merge activity lables with mean_std_data using activity_id
labelled_data <- merge(activity_labels, mean_std_data, by = "activity_id", sort = FALSE)

## remove duplicate column activity
final_dataset <- labelled_data[-1]

## optional step
## reorder final_dataset by interchanging 1st and 2nd column 
## Maintaining order for the rest of the columns i.e. 3:columns
num_of_columns <- ncol(final_dataset) ## get the number of columns of the dataset
final_dataset <- final_dataset[c(2,1,3:num_of_columns)]

## optional step
## order final_dataset by subject
final_dataset <- final_dataset[order(final_dataset$subject),]

## write final dataset into a txt file
write.table(final_dataset, file="UCI HAR Dataset/final_dataset.txt", row.names = F)

## Calcualted mean of the measurements aggregated by activity and subject

## columns to calculate means on. Exclude activity & subject columns
range <- 3:num_of_columns 
aggregated_dataset <- aggregate(final_dataset[, range], 
                      list(final_dataset$activity, final_dataset$subject), mean)

## rename the group columns appropriately
names(aggregated_dataset)[names(aggregated_dataset) == 'Group.1'] <- 'activity'
names(aggregated_dataset)[names(aggregated_dataset) == 'Group.2'] <- 'subject'

## write aggregated dataset into a txt file
write.table(aggregated_dataset, file="UCI HAR Dataset/aggregated_dataset.txt", 
            row.names = F)


