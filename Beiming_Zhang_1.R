# Beiming Zhang
# Class K2

# Q1
num1 <- 15
num2 <- 8
num1 * num2

# Q2
vec1 <- c(2, 4, 6, 8, 10)
length(vec1)
# As short as possible:
# print(length(vec1 <- c(2, 4, 6, 8, 10)))

# Q3
vec1[c(1, 3)]

# Q4
vec2 <- c(1, 3, 5, 7, 9)
vec1 + vec2

# Q5
num1 < 20 & num2 > 5
# In fact, I really like %in%,
# and I hate long strings of logical operators.
# so I believe the following code should also work:
# c(num1 < 20) %in% c(num2 > 5)

# Q6
scores <- c(85, 92, 78, 65, 90)
mean(scores)
# As short as possible:
# print(mean(scores <- c(85, 92, 78, 65, 90)))

# Q7
updated_scores <- scores + 10
updated_scores
# As short as possible:
# print(updated_scores <- c(scores + 10))

# Q8
curve <- c(-2, 3, 1,-5, 4)
print(updated_scores <- updated_scores + curve)

# Q9
scores[scores < 70]

# Q10
library(ISLR)
head(Auto)

# Q11
round(mean(Auto$mpg), 1)

# Q12
unique(Auto$cylinders)

# Q13
median(Auto$mpg[Auto$mpg > 25])

# Q14
Auto[Auto$name == "ford pinto",]
# I believe the following code should also work:
# Auto[Auto$name %in% "ford pinto", ]

# Q15
Auto[c(5:10),]

