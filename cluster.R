library(tm)
library(SnowballC)
library(wordcloud)
library(dplyr)
library(cluster)
library(factoextra)

data_Net <- read.csv("Data_Net.csv", stringsAsFactors = FALSE)

# 去除NA Remove NA
data <- data_Net
data <- na.omit(data)

# 标准化准备 Preparation for Standardization
mean_year <- mean(data$year)
mean_averageRating <- mean(data$averageRating)
mean_numVotes <- mean(data$numVotes)

sd_year <- sd(data$year)
sd_averageRating <- sd(data$averageRating)
sd_numVotes <- sd(data$numVotes)

# 对年份，评分，评分人数标准化 Standardize Year, Rating, and Number of Ratings
data$year <- scale(data$year)
data$averageRating <- scale(data$averageRating)
data$numVotes <- scale(data$numVotes)

# 清洗summary用语，删除无关部分 Clean Summary Language, Delete Irrelevant Parts
texts <- data$summary
corpus <- Corpus(VectorSource(texts))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("en"))
corpus <- tm_map(corpus, stemDocument)

dtm <- DocumentTermMatrix(corpus)

# 选择和过滤稀疏项，此处0.98以免纬度过多
# Select and Filter Sparse Items, Here 0.98 to Avoid Excessive Dimensions
dtm <- removeSparseTerms(dtm, 0.98)
matrix <- as.matrix(dtm)
summary(matrix)

# 合并所有数据 Merge All Data
data_pending <- cbind(data, matrix)
summary(data_pending)

# 简单处理以便跑K-mean Simple Processing for Running K-means
rownames(data_pending) <- data_pending$title
data_pending$title <- NULL
data_pending$summary <- NULL

# Warning! This part may take a long time to run
# 这段代码运行时间较长，可以考虑改变参数后分段运行
# 考虑的聚类数范围为1到30，观察最佳聚类
# Consider Cluster Number Range from 1 to 30, Observe Optimal Clustering
sil_width <- numeric(30)
for (i in 2:30) {
  km.res <- kmeans(data_pending, centers = i, nstart = 20)
  sil_width[i] <-
    mean(silhouette(km.res$cluster, dist(data_pending))[, 3])
}
plot(1:30,
     sil_width,
     type = "b",
     xlab = "Number of Clusters",
     ylab = "Average Silhouette Width")

# 跑K-mean Run K-means
set.seed(1)
data_cluster <- kmeans(data_pending, centers = 10)
print(data_cluster$cluster)

# 将聚类结果写回数据集 Write Cluster Results Back to Dataset
data_pending$cluster <- data_cluster$cluster

# 逆标准化 Reverse Standardization
data_pending$year_org <-
  (data_pending$year * sd_year) + mean_year
data_pending$averageRating_org <-
  (data_pending$averageRating * sd_averageRating) + mean_averageRating
data_pending$numVotes_org <-
  (data_pending$numVotes * sd_numVotes) + mean_numVotes
summary(data_pending)

# 根据聚类结果分类并导出结果
# Categorize and Export Results Based on Clustering Outcome
cluster_summary <- aggregate(. ~ cluster, data = data_pending, FUN = mean)
print(cluster_summary)
write.csv(round(cluster_summary,4), file = "output.csv", row.names = FALSE)
