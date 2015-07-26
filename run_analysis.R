library(plyr)

## Read in train datasets
setwd("C:/Users/john.lien/Desktop/R/Getting and Cleaning Data/Project/UCI HAR Dataset/train")

x_train <- read.table("x_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

## Read in test datasets
setwd("C:/Users/john.lien/Desktop/R/Getting and Cleaning Data/Project/UCI HAR Dataset/test")
x_test <- read.table("x_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

## Combine x datasets together
x_data <- rbind(x_train, x_test)

## Combine y datasets together
y_data <- rbind(y_train, y_test)

## Combine subject datasets together
subject_data <- rbind(subject_train, subject_test)

## Get mean & standard deviation from each measurement
setwd("C:/Users/john.lien/Desktop/R/Getting and Cleaning Data/Project/UCI HAR Dataset")
features <- read.table("features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]

## Read in activity names to label the dataset activities
setwd("C:/Users/john.lien/Desktop/R/Getting and Cleaning Data/Project/UCI HAR Dataset")
activities <- read.table("activity_labels.txt")
y_data[, 1] <- activities[y_data[, 1], 2]
names(y_data) <- "activity"

## Label dataset with descriptive names
names(subject_data) <- "subject"
alldata <- cbind(x_data, y_data, subject_data)

## Write out data with averages
setwd("C:/Users/john.lien/Desktop/R/Getting and Cleaning Data/Project")
averages_data <- ddply(alldata, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "average_data.txt", row.name=FALSE)
