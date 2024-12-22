#Reading the data
xtn <- read.table(".\\train\\X_train.txt")
ytn <- read.table(".\\train\\Y_train.txt")
stn <- read.table(".\\train\\subject_train.txt")
xtt <- read.table(".\\test\\X_test.txt")
ytt <- read.table(".\\test\\Y_test.txt")
stt <- read.table(".\\test\\subject_test.txt")
a_l <- read.table(".\\activity_labels.txt")
features <- read.table(".\\features.txt")
#Naming the columns names with distributive names
colnames(xtn) <- features[, 2]
colnames(xtt) <- features[, 2]
colnames(ytn) = "aID"
colnames(stn) = "sID"
colnames(ytt) = "aID"
colnames(stt) = "sID"
colnames(a_l) <- c("aID", "activity")
#Merging data into one data set
train <- cbind(xtn, stn, ytn)
test <- cbind(xtt, stt, ytt)
data <- rbind(train, test)
#Selecting the measurements on the mean and standard deviation with keeping ID variables
newdata <- select(data,
                  contains("sID"),
                  contains("aID"),
                  contains("-std"),
                  contains("-mean"))
#Naming the activities by descriptive names
labeleddata = merge(newdata , a_l, by = "aID", all.x = TRUE)

#Creating the second data set as required
grouped_data <- group_by(labeleddata,activity,sID)
vec <- colnames(labeleddata)
vec <- vec[3:81]
secdata <- summarise(grouped_data, across(vec, mean), .groups = "keep")
write.table(secdata,".\\data.txt",row.name=FALSE)
