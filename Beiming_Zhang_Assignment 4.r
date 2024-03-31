# BU.450.760.K1.SP24
# Assignment 4
# Beming Zhang

# Preparation of operating environment
library(tableone)
library(MatchIt)
library(lattice)
options(width = 120)
setwd(paste0(
    "/Users/velen/Documents/",
    "文稿-iCloud/Learning/JHU/Spring I/Customer Analytics/Class 5"
))
rm(list = ls())
ds <- read.csv("D5.2 Mashable.csv")

# Data cleaning
summary(ds)
table(ds$disclosed)
ds$category <- as.factor(ds$category)
ds$weekday <- as.factor(ds$weekday)

# Creat the treatment indicator
ds$treat_ind <- ifelse(ds$num_videos > 0, 1, 0)

# Task 1a
# Build the linear regression
model_t1 <- lm(shares ~ treat_ind, data = ds)
summary(model_t1)

# Task 2a
# Remove irrelevant covariates
drop_list <- c("url", "timedelta", "shares", "treat_ind", "num_videos")
xvars <- setdiff(names(ds), drop_list)

# Pre-match assessment of balance
table_unmatched <- CreateTableOne(
    vars = xvars, data = ds,
    strata = "treat_ind"
)
print(table_unmatched, smd = TRUE)

# Calculate the pscore
y_x <- as.formula(paste("treat_ind ~", paste(xvars, collapse = " + ")))
model_t2 <- glm(y_x, family = binomial, data = ds)

# Assess pscore overlap
ds$pscore <- predict(model_t2, type = "response")
histogram(~ pscore | treat_ind, data = ds)

# Draw reference lines
histogram(~ pscore | treat_ind,
    data = ds,
    panel = function(x, ...) {
        panel.histogram(x, ...)
        panel.abline(v = c(.04, .73), col = "red", lty = 2, lwd = 3)
    }
)

# Task 2b
# Perform matching by pscore
ds_matched <- ds[ds$pscore >= .04 & ds$pscore <= .73, ]
matched <- matchit(y_x, method = "nearest", data = ds)
ds_matched <- match.data(matched)
table(ds_matched$treat_ind)

# Task 2c
# Match assessment of balance
table_matched <- CreateTableOne(
    vars = xvars, data = ds_matched,
    strata = "treat_ind"
)
print(table_unmatched, smd = TRUE)
print(table_matched, smd = TRUE)

# Task 3a
# Build the linear regression based on ds_matched
model_t3 <- lm(shares ~ treat_ind, data = ds_matched)
summary(model_t3)
