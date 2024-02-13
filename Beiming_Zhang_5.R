# Q1 a)
Bikeshare <- read.csv("Bikeshare.csv")
summary(lm(Rentals ~ Temperature, data = Bikeshare))

# Q1 b)
summary(lm(Rentals ~ Humidity, data = Bikeshare))

# Q1 c)
summary(lm(Rentals ~ Windspeed, data = Bikeshare))

# Q1 d)
lm_wind <- summary(lm(Rentals ~ Windspeed, data = Bikeshare))
plot(Rentals ~ Windspeed, data = Bikeshare)
abline(lm_wind, lwd = 5, col = "Red")

# Q1 e)
lm_temp <- lm(Rentals ~ Temperature, data = Bikeshare)
plot(Rentals ~ Temperature, data = Bikeshare)
abline(lm_temp, lwd = 5, col = "Red")

# Q1 f)
pairs( ~ Rentals + Temperature + Humidity + Windspeed, data = Bikeshare)

# Q1 g)
summary(lm(Rentals ~ . - Day, data = Bikeshare))


# Q2
BikeshareUpdated <- read.csv("Bikeshare_updated.csv")
BikeshareUpdated$Weekend <- (BikeshareUpdated$Weekday %in% c(0, 6)) * 1
# I believe the following writing method is required by the professor:
# BikeshareUpdated$Weekend <-
#   ifelse((BikeshareUpdated$Weekday == 0) |
#            (BikeshareUpdated$Weekday == 6),
#          1,
#          0)

# Q2 a)
summary(lm(Rentals ~ Temperature + Humidity + Windspeed + Weekend,
           data = BikeshareUpdated))

# Q2 b)
summary(lm(Registered ~ Temperature + Humidity + Windspeed + Weekend, 
           data = BikeshareUpdated))

# Q2 c)
summary(lm(Casual ~ Temperature + Humidity + Windspeed + Weekend,
           data = BikeshareUpdated))
