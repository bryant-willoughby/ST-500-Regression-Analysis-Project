######
## Chapter 7: Problem with Predictors 
## Example Code 
## Bryant Willoughby 
###### 

library(faraway)
data(savings)
result <- lm(sr ~ ., data = savings)
summary(result)

#scale one pred var 
summary(lm(sr ~ pop15 + pop75 + I(dpi/1000) + ddpi, savings))

#standardize all variables 
  #note: intercept term practically zero 
sctemp <- data.frame(scale(savings))
summary(lm(sr ~ ., data = sctemp))




## Car dataset 
data(seatpos)
result <- lm(hipcenter ~ ., data = seatpos)
summary(result)

#correlation matrix 
round(cor(seatpos[,-9]),2) #excluding response var 

#condition number
  #large k (> 30) --> presence of collinearity 
X <- model.matrix(result)[,-1] #exclude intercept
e <- eigen(t(X) %*% X)
# e$val
round(sqrt(e$val[1]/e$val), 3)

#variance inflation factor (VIF)
  #large VIF (>10) --> presence of collinearity 
round(vif(X), 3)

#sensitivity to measurement errors 
  # make sure random error scale is similar to normal RV scale 
junk <- lm(hipcenter + 10*rnorm(38) ~ ., data = seatpos)
summary(junk)

#correlation of variables measuring length 
round(cor(X[, 3:8]), 2)

#using subset of predictor vars 
  #dropping highly correlated predictors
result2 <- lm(hipcenter ~ Age + Weight + Ht, data = seatpos)
summary(result2)


