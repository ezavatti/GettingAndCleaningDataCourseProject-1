library(reshape2)

# Download dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

# Uncompress the zip file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

path_rf <- file.path("./data" , "UCI HAR Dataset")

# Load the dataset files
activityTestData  <- read.table(file.path(path_rf, "test" , "y_test.txt" ),header = FALSE)
activityTrainData <- read.table(file.path(path_rf, "train", "y_train.txt"),header = FALSE)

subjectTestData  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
subjectTrainData <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)

featuresTestData <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
featuresTrainData <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

# Combine the test and training datasets
dataSubject <- rbind(subjectTrainData, subjectTestData)
dataActivity<- rbind(activityTrainData, activityTestData)
dataFeatures<- rbind(featuresTrainData, featuresTestData)

# Name the columns of the data
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# Replace the activity number with activity name
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
dataActivity<-merge(dataActivity,activityLabels,by=1)[,2]

# Merge it into one dataset 
Data <- cbind(dataSubject, dataActivity, dataFeatures)
names(Data)[2]<-c("activity")

# Select the columns with mean and std functions.
subdataFeaturesNames<-grep("-mean\\(|-std\\(",colnames(Data))
Data<-Data[,c(1,2,subdataFeaturesNames)]

# Rename the column names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("-?mean[(][)]-?", "Mean", names(Data))
names(Data)<-gsub("-?std[()][)]-?", "Std", names(Data))

# Compute the means, grouped by subject and activity
melted = melt(Data, id.var=c("subject", "activity"))
means = dcast(melted, subject + activity ~ variable, mean)

# Save the results into file
write.table(means, file = "tidy_dataset.txt",row.name=FALSE)

