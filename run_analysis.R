
## Basic Configuration : File Paths 
list.files(path = './UCI HAR Dataset')
file_path1 = './UCI HAR Dataset/features.txt'
file_path2 = './UCI HAR Dataset/activity_labels.txt'
## For Training Data 
file_path3 = './UCI HAR Dataset/train/X_train.txt'
file_path4 = './UCI HAR Dataset/train/y_train.txt'
## For Testing Data 
file_path5 = './UCI HAR Dataset/test/X_test.txt'
file_path6 = './UCI HAR Dataset/test/y_test.txt'
## For Subject Train 
file_path7 = './UCI HAR Dataset/train/subject_train.txt'
## For Subject Train 
file_path8 = './UCI HAR Dataset/test/subject_test.txt'
### End of Basic Configuration ### 


#1. Merges the training and the test sets to create one data set. 

## Get the X of training data as dataframe 
X_train <- read.table(file = file_path3)
head(X_train)
names(X_train)
## 561 features/columns  
nrow(X_train)
## 7352 observations

## Get the Labels (Y) of X training data as dataframe 
y_train <- read.table(file = file_path4)
head(y_train)
nrow(y_train)
## 7352 labels made for observations 
# changing to readable column names 
names(y_train)[names(y_train) == 'V1'] = "activitySNo"
head(y_train)

## Get the X of test data as dataframe 
X_test <- read.table(file = file_path5)
head(X_test)
names(X_test)
## 561 features/columns  
nrow(X_test)
## 2947 observations 

## Get the Labels (Y) of X testing data as dataframe 
y_test <- read.table(file = file_path6)
head(y_test)
nrow(y_test)
## 2947 labels
# changing to readable column names 
names(y_test)[names(y_test) == 'V1'] = "activitySNo"
head(y_test)

## ## Merge X of Training and Testing Data 
X_all = merge(X_train,X_test, all = TRUE)
nrow(X_all)
##10299 observations 
names(X_all)
## 561 features/columns 
## Merge y of Training and Testing Data 
y_all =  rbind(y_train, y_test)
nrow(y_all)
##10299 observations 
names(y_all)
#1 column: activitySNo  

## X_all
## y_all 
## End of Merging training and the test sets to create one data set

#2. Extracts only the measurements on the mean and standard deviation for each measurement.  

### First get the features 
features <- read.table(file = file_path1)
head(features)
names(features)
nrow(features)
## 561 features 
# changing to readable column names 
names(features)[names(features) == 'V2'] = "featureName"
names(features)[names(features) == 'V1'] = "featureSNo"
head(features)

## ### Lets change the columns names of X_all with features 

names(features)
featuresList <- features$featureName
featuresList
length(featuresList)
colnames(X_all)
colnames(X_all) <- featuresList
names(X_all)
length(names(X_all)) 
## 561 columns 


### ## Extracts only the measurements on the mean and standard deviation for each measurement. 
names(X_all)

names_mean_std = grep(pattern = "mean|std", x = names(X_all), value =  TRUE)
length(names_mean_std)
#79 
library(dplyr)
X_all.mean_std = select(.data = X_all, names_mean_std)
colnames(X_all.mean_std)
#79 columns
nrow(X_all.mean_std)
#10299 observations 

##  End of extracts only the measurements on the mean and standard deviation


#3. Uses descriptive activity names to name the activities in the data set

## First get the activity labels 
activityLabels <- read.table(file = file_path2)
head(activityLabels)
names(activityLabels)
nrow(activityLabels)
## 6 Activities 
# changing to readable column names 
names(activityLabels)[names(activityLabels) == 'V2'] = "activityName"
names(activityLabels)[names(activityLabels) == 'V1'] = "activitySNo"
head(activityLabels)


##4. Appropriately labels the data set with descriptive variable names.  
activityLabels
names(y_all)
library(dplyr)
y_all.updated = left_join(x = y_all, y = activityLabels)
names(y_all.updated)
# 2 columns "activitySNo"  "activityName"
nrow(y_all.updated)
# 10299 labels

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Get all subjects 

subject_train <- read.table(file = file_path7)
subject_test <- read.table(file = file_path8)
subject_all = merge(subject_train,subject_test, all = TRUE)
head(subject_all)
colnames(subject_all)[1] = "subject"
colnames(subject_all)
head(subject_all)
nrow(subject_all)

## adding a column activity to X_all.mean_std
X_all.mean_std$activtyName <- y_all.updated$activityName
names(X_all.mean_std)
class(X_all.mean_std$activtyName)


## adding a column subject to X_all.mean_std
X_all.mean_std$subject <- subject_all$subject
names(X_all.mean_std)
class(X_all.mean_std$subject)


data_by_activity_subject <- aggregate(X_all.mean_std[,1:79], by = list(by_activity = X_all.mean_std$activtyName, by_subject = X_all.mean_std$subject), FUN = mean)
write.table(data_by_activity_subject, file = "activity_subject_data.txt", sep = "\t",row.names = FALSE, col.names = TRUE)