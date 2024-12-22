xtn <- read.table(".\\train\\X_train.txt")
ytn <- read.table(".\\train\\Y_train.txt")
stn <- read.table(".\\train\\subject_train.txt")
xtt <- read.table(".\\test\\X_test.txt")
ytt <- read.table(".\\test\\Y_test.txt")
stt <- read.table(".\\test\\subject_test.txt")
a_l <- read.table(".\\activity_labels.txt")
features <- read.table(".\\features.txt")
colnames(xtn) <- features[,2]
colnames(xtt) <- features[,2]
colnames(ytn) = "aID"
colnames(stn) = "sID"
colnames(ytt) = "aID"
colnames(stt) = "sID"
colnames(a_l) <- c("aID","sID")
train <- cbind(xtn,stn,ytn)
test <- cbind(xtt,stt,ytt)
data <- rbind(train,test)
newdata = (grepl("aID" , colnames(data)) | grepl("sID" , colnames(data)) | grepl("mean.." , colnames(data)) | grepl("std.." , colnames(data)))
newdata <- data[,newdata]
labeleddata = merge(newdata , a_l, by="aID", all.x=TRUE)
labeleddata1 <- group_by(labeleddata,"sID.y")
labeleddata2 <- group_by(labeleddata,"aID")
secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
select(contains(""))
