# GCD-Project 

### Main project in the Coursera Getting and Cleaning Data course

The run_analysis.R script perfoms the following activities:

i. Download the Human Activity Recognition Using Smartphones Dataset from the url 
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
   
ii. Unzips the file to get two main sets of data, train and test datasets and text files describing the data

iii. Reads the test dataset
      - X-test.txt - the observations for the various activities 
      - y-test.txt - the activities
      - subject_test.txt - the participant in the study

iv. Merges the the 3 test data into one data frame (test_data)

v. Repeats step 3 and 4 above for the train dataset to create the train data frame (train_data)

vi. Get the feature labels for the datasets by reading the features.txt file

vii. Assign the labels to the data sets

viii. Merge the train and test data frames to create the combined_data data frame

ix. Determines which columns to include by grepping for mean or std in the columns.. use the labels read in step 6 above

x. Subsets the combined_data using the mean_std_columns calculated in step 9 to create the mean_std_data data frame

xi. Read in the activity labels from activity_labels.txt. 
    Rename columns to "activity_id" & "activity" to help with merge activity below
    
xii. Join the mean_std_data with the activity data frame using the activity id

xiii. Optional steps to remove duplicate column, reorder the columns and rank the final_dataset by subject

xiv. Write final dataset into a text file final_dataset.txt.

xv. Calcualted mean of the measurements aggregated by activity and subject and rename the groups appropriately.

xvi. write the aggregated dataset into a txt file
