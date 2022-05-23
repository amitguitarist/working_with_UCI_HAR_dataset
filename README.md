# Running the Script 

Step 1: Create a project folder 

Step 2: Unzip the UCI HAR dataset to create a folder structure inside the project folder created in Step 1      

UCI HAR Dataset/features.txt   
UCI HAR Dataset/activity_labels.txt    
UCI HAR Dataset/train/X_train.txt     
UCI HAR Dataset/train/y_train.txt   
UCI HAR Dataset/test/X_test.txt     
UCI HAR Dataset/test/y_test.txt    

Step 3: Copy the run_anlyisis.R script to the folder created in Step 1    

Step 4:  Run the run_analysis.R script in RStudio    
source('run_analysis.R')   

Step 5:  The full dataset is created as a txt file with the name 'activity_subject_data.txt'   
This file stores  the average value of each of the 561 features by activity and by subject.    

