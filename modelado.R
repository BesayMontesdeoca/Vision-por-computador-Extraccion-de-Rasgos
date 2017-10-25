rm(list = ls())

# Cargamos los datos
trainP = read.csv("data/trainPedestrians2.csv", header=FALSE)
trainP = cbind(trainP, sapply(1:dim(trainP)[1], function(n){return("P")})) # Le añadimos la clase correspondiente (Pedestrians -> P)
colnames(trainP)[length(trainP)] = "Class"

trainB = read.csv("data/trainBackground2.csv", header=FALSE)
trainB = cbind(trainB, sapply(1:dim(trainB)[1], function(n){return("B")})) # Le añadimos la clase correspondiente (Background -> B)
colnames(trainB)[length(trainB)] = "Class"

dataTrain = rbind(trainP, trainB)

testP = read.csv("data/testPedestrians2.csv", header=FALSE)
testP = cbind(testP, sapply(1:dim(testP)[1], function(n){return("P")}))
colnames(testP)[length(testP)] = "Class"

testB = read.csv("data/testBackground2.csv", header=FALSE)
testB = cbind(testB, sapply(1:dim(testB)[1], function(n){return("B")}))
colnames(testB)[length(testB)] = "Class"

dataTest = rbind(testP, testB)


library(randomForest)
library(caret)
library(e1071)
library(party)

# Función que realiza la predicción y el cálculo de las medidas
prediction = function(model, data){
  testPred = predict(model, newdata = data)
  
  # Cálculo de las medidas de precisión
  results = confusionMatrix(table(testPred, data[,ncol(data)]))
  accuracy = results$overall[1]
  sensitivity = results$byClass[1]
  specificity = results$byClass[2]
  gmean = sqrt(sensitivity * specificity)
  m = c(accuracy, sensitivity, specificity, gmean)
  names(m) = c("Accuracy", "Sencivility", "Specificity", "Gmean")
  print(m)
}

# Realizamos un shuffle de los datos
dataTrain = dataTrain[sample(nrow(dataTrain)),]
dataTest = dataTest[sample(nrow(dataTest)),]

# Modelos
mtree = ctree(Class ~ ., data = dataTrain)
rfM = randomForest(Class ~ ., dataTrain)
svmM = svm(Class ~ ., data = dataTrain)

prediction(mtree, dataTest)
prediction(rfM, dataTest)
prediction(svmM, dataTest)

