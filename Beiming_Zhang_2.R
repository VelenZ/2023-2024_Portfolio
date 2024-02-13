# Prepare the environment:
AutoLoss <-
  read.csv("AutoLoss.csv",
           na.strings = "?",
           stringsAsFactors = TRUE)
AutoLoss <- na.omit(AutoLoss)
library(lattice)


# Q1(a
table(AutoLoss$BodyStyle)

# Q1(b
round(prop.table(table(AutoLoss$BodyStyle)), 4)

# Q1(c
aggregate(Losses ~ BodyStyle, data = AutoLoss, FUN = mean)

# Q1(d
aggregate(Losses ~ BodyStyle + NumDoors, data = AutoLoss, FUN = mean)

# Q1(e
# Please check the answers in PDF.

# Q1(f
AutoLoss_rwd <- AutoLoss[AutoLoss$DriveWheels == "rwd",]
aggregate(Losses ~ BodyStyle, data = AutoLoss_rwd, FUN = mean)

# Q1(g
# Please check the answers in PDF.


# Q2(a
q2a <- aggregate(Losses ~ NumDoors, data = AutoLoss, FUN = mean)
barchart(Losses ~ NumDoors,
         data = q2a,
         xlab = "NumDoors",
         ylab = "Mean # Losses")

# Q2(b
q2b <- AutoLoss[order(AutoLoss$Losses), ]
q2b <- q2b[1:10, ]
aggregate(Losses ~ BodyStyle, data = q2b, FUN = mean)
# If someone need a chart:
q2b_b <- aggregate(Losses ~ BodyStyle, data = q2b, FUN = mean)
barchart(Losses ~ BodyStyle,
         data = q2b_b,
         xlab = "BodyStyle",
         ylab = "Mean # Losses")

# Q2(c
bwplot(Losses ~ DriveWheels,
       data = AutoLoss,
       xlab = "DriveWheels",
       ylab = "Losses")

# Q3(d
xyplot(Losses ~ Price, data = AutoLoss)
