
rawcolnames <- read.table("features.txt")
datacolnames <- rawcolnames[,2]

xtrain <- read.table("X_train.txt")
colnames(xtrain) <- datacolnames

subject <- read.table("subject_train.txt")
colnames(subject) <- c("subject")

xtrain_id <- read.table("y_train.txt")
colnames(xtrain_id) <- c("traintype")

xtrain_cv <- as.data.frame(matrix(rep("xtrain",nrow(xtrain)),ncol=1, nrow=nrow(xtrain)))
colnames(xtrain_cv) <- c("sourcetype")

data1 <- cbind(xtrain_id, subject, xtrain_cv, xtrain)


xtest <- read.table("X_test.txt")
colnames(xtest) <- datacolnames

subject <- read.table("subject_test.txt")
colnames(subject) <- c("subject")

xtest_id <- read.table("y_test.txt")
colnames(xtest_id) <- c("traintype")

xtest_cv <- as.data.frame(matrix(rep("xtest",nrow(xtest)),ncol=1, nrow=nrow(xtest)))
colnames(xtest_cv) <- c("sourcetype")

data2 <- cbind(xtest_id, subject, xtest_cv, xtest)

data <- rbind(data1, data2)

tidied_ix <- c(1,2,3, grep("mean|std|Mean", colnames(data))  )

tidydata <- data[tidied_ix]

write.table(tidydata,sep=",", file="tidydata.txt",row.name=FALSE)

