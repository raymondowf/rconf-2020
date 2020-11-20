library(randomForest)
set.seed(2020)

# assign the samples into train and test data, respectively in the 7:3 split ratio.
ind <- sample(2,nrow(iris),replace=TRUE,prob=c(0.7,0.3))
trainData <- iris[ind==1,]
testData <- iris[ind==2,]

# train a random forest model using the train dataset.
iris_rf <- randomForest(Species~.,data=trainData,ntree=100,proximity=TRUE)
# save the model in the RDS format.
saveRDS(iris_rf, file = 'model.rds')

#table(predict(iris_rf),trainData$Species)
#irisPred<-predict(iris_rf,newdata=data.frame(Sepal.Length = 5.4, Sepal.Width = 3.7, Petal.Length = 1.5, Petal.Width = 0.2))
