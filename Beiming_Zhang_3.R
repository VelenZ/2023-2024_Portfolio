# Programming Part
# Question 1
# Prepare the operating environment:
Rankings <- read.csv("StateRankings.csv")
set.seed(5)

# Q1 (a)
Rankings_hcecon <- Rankings[, c("Healthcare", "Economy")]
# To ensure uniformity in subsequent output, 
# the original serial number is replaced with the state name.
rownames(Rankings_hcecon) <- Rankings$State
hcecon_k <- kmeans(Rankings_hcecon, 5, nstart = 20)
hcecon_k

# Q1 (b)
plot(
  Rankings_hcecon$Economy,
  Rankings_hcecon$Healthcare,
  col = hcecon_k$cluster,
  pch = hcecon_k$cluster,
  xlab = "Economy",
  ylab = "Healthcare"
)
# Use the row.names to retrieve the state names from the Rankings_hcecon.
# The goal is to minimizing the number of variable in a single statement.
# Do the same in Question 2 (c).
text(
  x = Rankings_hcecon$Economy,
  y = Rankings_hcecon$Healthcare - 1.0,
  labels = row.names(Rankings_hcecon),
  col = hcecon_k$cluster
)


# Question 2
# Q2 (a) 
hcecon_hc <- hclust(dist(Rankings_hcecon), method = "complete")
plot(hcecon_hc)

# Q2 (b)
# Observe the impact of different numbers of clusters.
# Place all possible outcomes on one chart for easy observation.
plot(hcecon_hc, main = "Cluster Dendrogram: 2 to 7 clusters")
for (i in 2:7) {
  rect.hclust(hcecon_hc, k = i)
}
plot(hcecon_hc, main = "Cluster Dendrogram: 5 clusters")
rect.hclust(hcecon_hc, k = 5)

# Q2 (c)
hcecon_hc_scaled <- cutree(hcecon_hc, 5)
plot(
  Rankings_hcecon$Economy,
  Rankings_hcecon$Healthcare,
  col = hcecon_hc_scaled,
  pch = hcecon_hc_scaled,
  xlab = "Economy",
  ylab = "Healthcare"
)
text(
  x = Rankings_hcecon$Economy,
  y = Rankings_hcecon$Healthcare - 1.0,
  labels = row.names(Rankings_hcecon),
  col = hcecon_hc_scaled
)
