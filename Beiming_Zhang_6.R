# Question 1
titanic_log <- read.csv("TitanicforLogReg.csv")
set.seed(1)
train_row <- sample(1:nrow(titanic_log), nrow(titanic_log) * 0.5)
titanic_train <- titanic_log[train_row, ]
titanic_test <- titanic_log[-train_row, ]

# a)
round(prop.table(table(titanic_train$Survived)), 4)
round(prop.table(table(titanic_test$Survived)), 4)

# b)
titanic_glm_b <- glm(Survived ~ Gender + Child + Fare + Class ,
                     family = binomial,
                     data = titanic_train)
summary(titanic_glm_b)

# c)
titanic_glm_c <- glm(Survived ~ Gender + Child + Class ,
                     family = binomial,
                     data = titanic_train)
summary(titanic_glm_c)

# d)
titanic_glm_probs <-
  predict(titanic_glm_c, titanic_test, type = "response")
titanic_glm_probs
titanic_test$Pred <- ifelse(titanic_glm_probs > .5,1,0)
titanic_test$Pred

# e)
round(prop.table(table(
  titanic_test$Survived, titanic_test$Pred
)), 4)
round(mean(titanic_test$Survived == titanic_test$Pred), 4)
