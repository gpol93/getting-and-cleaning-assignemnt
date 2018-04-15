# install Packages and downlading the data
install.packages("reshape2")
install.packages("data.table")
library(reshape2)
library(data.table)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))

#Unzipping the data set
unzip(zipfile = "dataFiles.zip")

# Load activity labels + features
activityLabels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "featureNames"))
#Let's get the features we want
wantedfeatures <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[wantedfeatures, featureNames]
measurements <- gsub('[()]', '', measurements)

# Load train datasets
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, wantedfeatures, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                         , col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubjectNum"))
train <- cbind(trainSubjects, trainActivities, train)

# Load test datasets
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, wantedfeatures, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
tidytable <- rbind(train, test)

# Transform class labels to activity name
tidytable[["Activity"]] <- factor(tidytable[, Activity]
                                 , levels = activityLabels[["classLabels"]]
                                 , labels = activityLabels[["activityName"]])

tidytable[["SubjectNum"]] <- as.factor(tidytable[, SubjectNum])
tidytable<- reshape2::melt(data = tidytable, id = c("SubjectNum", "Activity"))
tidytable <- reshape2::dcast(data = tidytable, SubjectNum + Activity ~ variable, fun.aggregate = mean)

write.table(tidytable, "TidySet.txt", row.name=FALSE)
