######
## Chapter: Poisson Data 
## Example Code 
## Bryant Willoughby 
###### 

# load libraries 
library(faraway)


## Galapagos example 
  # modeling the number of species of tortoise 
  # many small counts; normal approx. may not be accurate 
data(gala)
help(gala)
attach(gala)

# remove endemics variable 
gala = gala[,-2]


# fit poisson regression 
  # neither the intercept or current model fit the data well 
  # (possibly due to overdispersion)
galap = glm(Species ~ ., family=poisson, data=gala)
summary(galap)

# plot estimated variance against the mean 
  # larger variance for larger mean values
  # informal (visual) evidence to suggest instead estimate variance 
plot(galap$fit, residuals(galap, type="response")^2, 
      xlab = expression(hat(mu)), 
      ylab = expression((y - hat(mu))^2))

# estimate sigma2
  # est \approx 31
  # should be around 1 if poisson data assumption satisfied 
sigma2 = sum(residuals(galap, type="pearson")^2 / galap$df.res)
sigma2

# use estimated dispersion to recompute p-values; check new model fit 
  # estimated coefficients unchanged
  # SEs and correspnoding testing results are changed 
summary(galap, dispersion=sigma2)





