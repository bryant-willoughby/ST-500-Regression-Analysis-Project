######
## Chapter 11: Shrinkage Methods 
## Example Code 
## Bryant Willoughby 
###### 


# Load necessary libraries  
library(faraway)
library(MASS)
library(lars)
library(Metrics)

# Food Analyzer Example 
  # response: fat content 
  # predictors: 100 channel spectrum of absorbances
data(meatspec); dim(meatspec)
matplot(t(meatspec[c(1:10), c(1:100)]), pch = "*", 
        xlab = "channel spectrums", ylab = "absorbances")

# Data (n = 215); preds (p = 10)
  # training: 172, test: 43
trainmeat = meatspec[1:172,]
testmeat = meatspec[173:215,]

# Ridge regression 
  # lm.ridge: automatically centers training data 
  # candidate set of tuning parameters: seq-range below:
modridge = lm.ridge(fat ~ ., lambda = seq(0, 5e-8, 1e-9), 
                    data = trainmeat)
matplot(modridge$lambda, t(modridge$coef), type="l", lty=1,
        xlab = expression(lambda), ylab = expression(hat(beta)))

# select an appropriate lambda
  # use CV procedure to select appropriate lambda 
  # Select lambda by minimizing GCV
idx <- which.min(modridge$GCV)
lambda_hat <- modridge$lambda[idx]
abline(v=lambda_hat)
lambda_hat

plot(modridge$GCV)
abline(v=idx)


# compute fitted results manually 
  # modridge$coef: after standardization 
  # modridge$coef[,19]: original scale
yfit = modridge$ym + scale(trainmeat[,-101], center=modridge$xm, 
                           scale=modridge$scales) %*% modridge$coef[,idx]
rmse(yfit, trainmeat$fat)

# predict on test data 
ypred = modridge$ym + scale(testmeat[,-101], center=modridge$xm, 
                            scale=modridge$scales) %*% modridge$coef[,idx]
rmse(ypred, testmeat$fat)


# Life Expectancy Example 
  # census data from 50 states 
  # response: life expectancy in years (1969-71)
data(state)
statedata <- data.frame(state.x77, row.names = state.abb)

# Lasso Example 
lmod <- lars(as.matrix(statedata[,-4]), statedata$Life)
plot(lmod)

# Laso: picking \lambda or t 
  # utilize 10-fold cross validation 
cvlmod <- cv.lars(as.matrix(statedata[,-4]), statedata$Life)
lambda = cvlmod$index[which.min(cvlmod$cv)]
abline(v=lambda)

# fit model with selected lambda 
  # 3 predictors numerically zero 
  # lasso coefs are smaller in magnitude, i.e. are shrinking towrads zero
predict(lmod, s = lambda, type = "coef", mode = "fraction")$coef
coef(lm(Life.Exp ~ Population + Murder + HS.Grad + Frost, statedata))

