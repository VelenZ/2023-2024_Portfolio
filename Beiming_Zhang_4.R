# Q1
library(tree)
AutoLoss <-
  read.csv("AutoLoss-DT.csv",
           na.strings = "?",
           stringsAsFactors = TRUE)
AutoLoss <- na.omit(AutoLoss)
set.seed(5)

# Q1_a
full_dataset <- AutoLoss
tree_origin <- tree(HighLoss ~ . , data = full_dataset)
plot(tree_origin)
text(tree_origin, pretty = 4)

# Q1_b
cv.tree(tree_origin, FUN = prune.misclass)
# "Non sunt multiplicanda entia sine necessitate."
tree_prune <- prune.misclass(tree_origin, best = 6)
plot(tree_prune)
text(tree_prune, pretty = 4)


# Q2
library(class)
titanic_knn <- read.csv("TitanicforKNN.csv")
class(titanic_knn)

# Q2_a
set.seed(1)
train_row <- sample(1:nrow(titanic_knn), nrow(titanic_knn) * 0.5)
titanic_train <- titanic_knn[train_row, ]
titanic_test <- titanic_knn[-train_row, ]

titanic_train_preds <- titanic_train[, -1]
titanic_test_preds <- titanic_test[, -1]
titanic_train_survived <- titanic_train[, 1]
titanic_test_survived <- titanic_test[, 1]

knn_k2 <- knn(titanic_train_preds,
              titanic_test_preds,
              titanic_train_survived,
              k = 2)
prop.table(table(knn_k2, titanic_test_survived))
knn_k2_acc <- mean(knn_k2 == titanic_test_survived)

knn_k4 <- knn(titanic_train_preds,
              titanic_test_preds,
              titanic_train_survived,
              k = 4)
prop.table(table(knn_k4, titanic_test_survived))
knn_k4_acc <- mean(knn_k4 == titanic_test_survived)

knn_k6 <- knn(titanic_train_preds,
              titanic_test_preds,
              titanic_train_survived,
              k = 6)
prop.table(table(knn_k6, titanic_test_survived))
knn_k6_acc <- mean(knn_k6 == titanic_test_survived)

# Q2_b
c("k=2" = knn_k2_acc,
  "k=4" = knn_k4_acc,
  "k=6" = knn_k6_acc)
