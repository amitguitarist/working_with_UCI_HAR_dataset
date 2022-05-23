## Basic Configuration of variable  : File Paths 
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

## Get the X of training data and store in  dataframe 
X_train <- read.table(file = file_path3)

## Get the Labels (Y) of X training data and store in  dataframe 
y_train <- read.table(file = file_path4)

## Get the X of test data and store in  dataframe 
X_test <- read.table(file = file_path5)

## Get the Labels (Y) of X testing data and store in dataframe 
y_test <- read.table(file = file_path6)

## ## Merge X of Training and Testing Data 
X_all = merge(X_train,X_test, all = TRUE)

### Get the features 
features <- read.table(file = file_path1)

## Get the activity labels 
activityLabels <- read.table(file = file_path2)

## Get all subjects and create one dataframe
subject_train <- read.table(file = file_path7)  
subject_test <- read.table(file = file_path8)   
subject_all = merge(subject_train,subject_test, all = TRUE)

##storing the final data as dataframe 
data_by_activity_subject <- aggregate(X_all.mean_std[,1:79], by = list(by_activity = X_all.mean_std$activtyName, by_subject = X_all.mean_std$subject), FUN = mean)


