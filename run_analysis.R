## Getting and Cleaning Data: Course Project
## https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3

## Load required packages
if (!require("plyr")) {
  install.packages("plyr")
}
require("plyr")

## Download and decompress data & record date of download
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data")){
  dir.create("./data")
  message("Creating data directory.")
}
if(!file.exists(".data/UCI HAR Dataset")) {
  download.file(fileURL, destfile="./data/Dataset.zip")
  date.downloaded = date()
  message("Decompressing data ...")
  unzip(zipfile="./data/Dataset.zip", exdir="./data")
  message("Data decompressed.")
}

## Read, merge and select required data from all three datasets
datapath <- file.path("./data/UCI HAR Dataset")
message("Reading data ...")

xtrain <- read.table(paste0(datapath, "/train/X_train.txt"))
xtest <- read.table(paste0(datapath, "/test/X_test.txt"))

ytrain <- read.table(paste0(datapath, "/train/y_train.txt"))
ytest <- read.table(paste0(datapath, "/test/y_test.txt"))

subjecttrain <- read.table(paste0(datapath, "/train/subject_train.txt"))
subjecttest <- read.table(paste0(datapath, "/test/subject_test.txt"))

activities <- read.table(paste0(datapath, "/activity_labels.txt"))
names(activities) <- c("activity_id", "activity")                     

features <- read.table(paste0(datapath, "/features.txt"))

## Merge xtrain and xtest and reduce to means and stds coloums
message("Merging data ...")
x <- rbind(xtrain, xtest)
names(x) <- features[,2]

means <- grep("-mean\\(\\)", features[,2], value=TRUE)
stds <- grep("-std\\(\\)", features[,2], value=TRUE)
x <- x[, c(means, stds)]

# Merge ytrain and ytest and use descriptive activity names
y <- rbind(ytrain, ytest)
names(y) <- "activity"
labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
for (i in 1:6) y$activity[y$activity == i] <- labels[i]

# Merge subjecttrain and subjecttest and use descriptive column name
subject <- rbind(subjecttrain, subjecttest)
names(subject) <- c("subject")

# Merge x (means & stds), y (activities) and subjects into one dataframe
df <- cbind(x, y, subject)

# Tidy data and write output file
message"Tidying data ..."
names(df) = gsub('-mean', 'Mean', names(df))
names(df) = gsub('-std', 'Std', names(df))
names(df) = gsub('[-()]', '', names(df))
tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[, 1:60]))

write.table(tidy, file=paste0(datapath,"UCI_HAR_tidy.txt"), row.names = FALSE)
message("Done.")
