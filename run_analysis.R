# This is the program for the "Getting and Cleaning data course project"
# 
#This program assumes that the UCI HAR dataset has already been downloaded and
# the  working directory has been set to where UCI HAR dataset is
# 
#The obejective of this program is to create a tidy dataset consisting of the 
# the mean of each varaible for each subject for each of the 6 activities.
#The overall project is described more full in the markdown document ReadMe.md
# and the data are described in the document CodeBook.md
#
# This is accomplished in five phases:
# 1.  Read in all raw data (test, training, featires, lables).
# Merge the training and the test sets to create one data set.
# 2.Extract only the measurements on the mean and standard deviation for each measurement. 
# 3.Use descriptive activity names to name the activities in the data set
# 4.Appropriately label the data set with descriptive variable names. 
# 5.Create a independent tidy data set (tidy_data_set.txt), with the 
#  average of each variable for each activity and each subject
# this data set contains 180 rows (30 subjects * 6 activities)

#1.Read in test data for class project

# Run this prgram ONLY after setting working directory to loaction of 
#set working directory to where UCI HAR dataset is located


# read in feature info that will be used as header for "x" 

features <- read.table(file="features.txt", header=FALSE)
feat_names <- as.character(features[,2])

# read in test obs
y_test <- read.table(file="./test/y_test.txt", header=FALSE)
names(y_test) <- "activityNumb"
subj_test <- read.table(file="./test/subject_test.txt", header=FALSE)
names(subj_test) <- "subjectNumb"
x_test <- read.table(file="./test/x_test.txt", header=FALSE)
names(x_test) <-feat_names
all_test <- cbind(subj_test,y_test,x_test )
# now read in train obs
y_train <- read.table(file="./train/y_train.txt", header=FALSE)
names(y_train) <- "activityNumb"
subj_train <- read.table(file="./train/subject_train.txt", header=FALSE)
names(subj_train) <- "subjectNumb"
x_train <- read.table(file="./train/x_train.txt", header=FALSE)
# assign column names to all the xtrain data as the feature names we just read in
names(x_train) <-feat_names
all_train <- cbind(subj_train,y_train,x_train )
# now combine test and train data
raw_data <-rbind(all_test,all_train)


# part 2  - 2.Extracts only the measurements on the mean 
#          and standard deviation for each measurement

metric_data<-raw_data[,feat_names[grepl("mean\\()|std\\()", feat_names)]]
# keep subj number and activity number from raw data
inf_data<-raw_data[,1:2]
# now comine subsject number, activity number , and mean and std columns
 data_pt2 <-cbind(inf_data,metric_data)

# Part 3 - 3.Uses descriptive activity names to name the activities in the data set

# read in activty lables and assign column names so we can merge on activitynumb
activityLabels <- read.table(file="activity_labels.txt", header=FALSE, col.names=c("activityNumb","activityName"))
#merge to add activity label
data_pt3 <- merge(data_pt2, activityLabels, by="activityNumb", sort=FALSE)
# now re-arrange columns so label is with subject
idcols<-c(names(data_pt3)[1:2],"activityName")
cols <- c(idcols, names(data_pt3)[-which(names(data_pt3) %in% idcols)])
data_pt3 <-data_pt3[cols]
# now that we have activity name, we can delete activity number
data_pt3 <- data_pt3[ !names(data_pt3)=="activityNumb"]

# Part 4 - Appropriately labels the data set with descriptive variable names. 
# subset all data except cols 1 and 2 to cleanup names

data_pt4a <- data_pt3[,3:ncol(data_pt3)]
#convert names to lower case
names(data_pt4a) <- tolower(names(data_pt4a))
names(data_pt4a) <-gsub("\\-|\\()","",names(data_pt4a))
# eliminated dulplicate "body"
names(data_pt4a) <-gsub("bodybody","body",names(data_pt4a))
names(data_pt4a) <-gsub("std","StandardDeviation",names(data_pt4a))
names(data_pt4a) <-gsub("mean","Mean",names(data_pt4a))
names(data_pt4a) <-gsub("x$","XDirection",names(data_pt4a))
names(data_pt4a) <-gsub("y$","YDirection",names(data_pt4a))
names(data_pt4a) <-gsub("z$","ZDirection",names(data_pt4a))
names(data_pt4a) <-gsub("^t","Time",names(data_pt4a))
names(data_pt4a) <-gsub("^f","Frequency",names(data_pt4a))
names(data_pt4a) <-gsub("body","Body",names(data_pt4a))
names(data_pt4a) <-gsub("acc","Acc",names(data_pt4a))
names(data_pt4a) <-gsub("gravity","Gravity",names(data_pt4a))
names(data_pt4a) <-gsub("gyro","Gyro",names(data_pt4a))
names(data_pt4a) <-gsub("jerk","Jerk",names(data_pt4a))
names(data_pt4a) <-gsub("mag","Magnitude",names(data_pt4a))
#add descriptive columns back
data_pt4 <-data.frame(cbind(data_pt3[,1:2],data_pt4a))

#part 5 - 5.Create a second, independent tidy data set with the average of each variable 
#for each activity and each subject


data_pt5<- aggregate(data_pt4[3:68],by=list(SubjectNumb=data_pt4$subjectNumb, ActivityName=data_pt4$activityName),FUN=mean,na.rm=TRUE)
#write this tidy sett to a text file

if (!file.exists("data")) {
        dir.create("data")       
        
}
write.table(data_pt5, file="./data/tidy_data_set.txt", row.names=FALSE, col.names=TRUE)




