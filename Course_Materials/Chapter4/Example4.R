######
## Chapter 4: Prediction 
## Example Code 
## Bryant Willoughby 
######

# load data 
library(faraway)
help(savings)
data(savings)
savings <- savings
head(savings)

# confidence intervals for predictions 
result <- lm(sr ~ pop15 + pop75 + dpi + ddpi, savings)
#convenient way to compute CI and PI 
x0 <- data.frame(pop15=35, pop75=2, dpi=1000, ddpi=4)
predict(result, x0, interval = "confidence")
predict(result, x0, interval = "prediction")

# prediction band plot 
#generate a sequence of points
grid <- seq(20, 60, 1)
pred <- predict(result, data.frame(pop15 = grid, pop75=2, 
                                   dpi = 1000, ddpi = 4), interval = "confidence")
#plot a matrix
matplot(grid, pred, lty=c(1,2,2), col=1, type = "l", xlab = "pop15", ylab = "sr")
rug(savings$pop15) #what is this doing? 


