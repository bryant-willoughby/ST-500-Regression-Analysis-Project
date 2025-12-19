######
## Chapter 8: Problems with Errors 
## Example Code 
## Bryant Willoughby 
###### 

library(faraway)

## French Election Example 
# help(fpe)
data(fpe)

# fit a linear model with no intercept 
        # weighted least squares 
g <- lm(A2 ~ A+B+C+D+E+F+G+H+J+K+N-1, 
        data=fpe, weights = 1/EI)
round(g$coef, 3)

# fit OLS model with no intercept 
        # larger county sizes dominate results 
        # unweighted least squares
lm(A2 ~ A+B+C+D+E+F+G+H+J+K+N-1, data=fpe)      

# set coefficients bigger than 1 to 1 
lm(A2 ~ offset(A+G+K)+C+D+E+F+J+N-1, data=fpe, weights = 1/EI)$coef

# remove coefficients less than 0 (i.e. drop J)
lm(A2 ~ offset(A+G+K)+C+D+E+F+N-1, data=fpe, weights = 1/EI)$coef

## Longley Data Example
# help(longley)
data(longley)
g <- lm(Employed ~ GNP + Population, data=longley)
summary(g)

# fit GLS with AR(1) structure 
library(nlme)
g <- gls(Employed ~ GNP + Population, 
         correlation = corAR1(form = ~ Year), 
         data = longley)
summary(g)

# testing \rho = 0
  # CI excludes 0; evidence to suggest correlated errors
intervals(g)


## Gala data example 
data(gala)
g <- lm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, 
        data = gala)
summary(g)

# huber's method 
  # consistency w/ significance of preds from above OLS results 
  # minor deviations in coefficients; signs are similar 
library(MASS)
ghuber <- rlm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, 
             data = gala)
summary(ghuber)

# least-absolute deviations 
  # Adjacent term no longer statistically significant 
library(quantreg) # quantile regression 
glad <- rq(Species ~ Area + Elevation + Nearest + Scruz + Adjacent, 
           data = gala)
summary(glad)





