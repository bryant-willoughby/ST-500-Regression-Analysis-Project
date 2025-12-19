######
## Chapter: Binomial Data 
## Example Code 
## Bryant Willoughby 
###### 

# load libraries 
library(faraway)
library(MASS)

# Challenger Disaster Data 
data(orings)

# fit linear model to observed proportions 
  # clearly inappropriate here 
  # there are 6 possible oring failures 
plot(damage/6 ~ temp, orings, xlim = c(25, 85), 
     ylim = c(0, 1), ylab = "Probability of damage")
abline(lm(damage/6 ~ temp, orings))

# fit a logistic regression model 
  # Y = damage or not; cbind(Y_i, n_i - Y_i)
  # logistic link function for binomial data 
logitm = glm(cbind(damage, 6-damage) ~ temp, 
             family = binomial(link = logit), data = orings)
summary(logitm)


# estimate prob at temp = 31
  # ilogit: computes inverse logit transformation 
test = data.frame(temp=31)
ilogit(predict(logitm, test))

# fit a probit model to compare 
probitm = glm(cbind(damage, 6-damage) ~ temp, 
              family = binomial(link = probit), data = orings)
summary(probitm)


# probit prediction at temp = 31 
  # pnorm: normal cdf prob. calculation 
pnorm(predict(probitm, test))

# make predictions for the whole range and plot 
range = data.frame(temp = seq(25, 85, by = 1))
pred.l = ilogit(predict(logitm, range))
pred.p = pnorm(predict(probitm, range))
matplot(range, cbind(pred.l, pred.p), xlim = c(25, 85), 
        ylim = c(0, 1), xlab = "Temperature", ylab = "Prob of damage", 
        type = "ll", lty = c('solid', 'dashed'))

# Goodness of fit test 

# compare null to model with temperature 
  # null: intercept model; alternative: fitted model 
  # small p; reject null; evidence in favor of fitted model 
pchisq(logitm$null.dev - logitm$dev, 
       df = logitm$df.null - logitm$df.resid, lower.tail=F)

# deviance test
  # null: fitted model; alternative: saturated model (least restrictive)
  # p = 0.72; FTR null; significant fitted model
pchisq(logitm$dev, df = logitm$df.resid, 
       lower.tail = F)

# Pearson's chi-squared 
  # null: fitted model alternative: saturated model
  # p=0.14; FTR null; significant fitted model 
X2 = sum(residuals(logitm, type="pearson")^2)
pchisq(X2, df=logitm$df.residual, lower=F)


# Confidence Intervals for Parameters 
confint(logitm)

# Confidence intervals for predictions 
  # test: temp = 31
predict(logitm, test, se=T)
  # 95% CI for p(xo)
ilogit(c(4.959746 - 1.96*1.66731, 4.959746 + 1.96*1.66731))

## Trout data 
data(troutegg)
attach(troutegg)

# fit model 
  # intercept model alone does not fit data well 
  # large residual deviance --> not good fit (maybe overdispersion)
tmod = glm(cbind(survive, total-survive) ~ location + period, 
           family = "binomial", data  = troutegg)
summary(tmod)

# estimate sigma2 
  # 12 = n - (p + 1)
sigma2 = sum(residuals(tmod, type="pearson")^2)/12
sigma2 #5.33; should be around 1 if binomial data assumption satisfied 


drop1(tmod, scale=sigma2, test="F") #don't need to drop anything

# use estimated dispersion to recompute p-values; check new model fit 
  # estimated coefficients unchanged 
  # SE are about 2/3 times larger (sqrt(5.33)) and corresponding z-test & p-val
  # note: cannot use deviance for goodness of fit measure 
    # instead use approximate F-test as needed
summary(tmod, dispersion=sigma2)





