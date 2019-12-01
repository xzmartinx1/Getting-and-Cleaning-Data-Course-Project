# Getting-and-Cleaning-Data-Course-Project

Script:
Utlizes the reshape2 package

Downloads and unzips all necessary data to the working direcotry.

Features being measured in experiment from file features.txt.

Loads complete data for train and test sets that include measurements from X_train.txt as a data frame.

The data frame column names are updated to be more user friendly. 

Activity labels and subjects for measurements are also loaded from files train/y_train.txt and train/subject_train.txt and added to data frame as separated columns.

The same procedure is coducted for test dataset.

The final result is 2 rows of 2 data frames that are merged together to form are data frame with complete data.

Utilize grep to finds column names that includes "mean()" or "std()" measurements.

A new data frame with only necessary columns is created. 

A new variable "activitylabel" is added to the dataset to provide descriptive values for activity labels. This variable is a factor variable with levels mentioned in file activity_labels.txt 

A melted data frame using activity label and subject as ids is created.

Mean values for all variables are calculated and grouped by activity and subject using dcast() function.

A tidy data frame is then created. 
