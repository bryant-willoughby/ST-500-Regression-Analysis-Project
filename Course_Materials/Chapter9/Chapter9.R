######
## Chapter 9: Transformation  
## Example Code 
## Bryant Willoughby 
###### 

library(faraway)

## Savings and Galapagos Tortoise Examples 
library(MASS)

# Box-Cox method for Savings data 
g <- lm(sr ~ pop15 + pop75 + dpi + ddpi, savings)
boxcox(g, plotit=T)
boxcox(g, plotit=T, lambda = seq(0.5, 1.5, by=0.1))

# Box-Cox method for Toirtoise data 
  # lambda approx 1/3 more appropriate 
g <- lm(Species ~ Area + Elevation + Nearest + 
          Scruz + Adjacent, gala)
boxcox(g, plotit=T)
boxcox(g, plotit=T, lambda = seq(0, 1, by=0.05))


# Transformation in the Tortoise example 
summary(lm(Species ~ Area + Elevation + Nearest + 
     Scruz + Adjacent, gala))
summary(lm(Species^(1/3) ~ Area + Elevation + Nearest + 
             Scruz + Adjacent, gala))

# Savings Example 
attach(savings)

# polynomials 

## forward selection 

# 1st degree 
summary(lm(sr ~ ddpi))

# 2nd degree; d = 2; significant terms 
summary(lm(sr ~ ddpi + I(ddpi^2)))

# 3rd degree; d = 3; insignificant cubic term 
  # correlated higher-order terms => all terms now not significant 
summary(lm(sr ~ ddpi + I(ddpi^2) + I(ddpi^3)))


## backwards selection 

# artificial data; transforming predictor first 
  # not significant linear term; contradicts above result w.r.t linear term 
  # higher order significance (can be) influenced by transformed preds 
mddpi = ddpi - 10
summary(lm(sr ~ mddpi + I(mddpi^2)))

# orthogonal polynomials 
  # default orthogonal predictor fitting using poly() 
  # raw = T => raw data without orthogonal transform 
summary(lm(sr ~ poly(ddpi, 4)))

# polynomials in several predictors 
  # consult output here 
g = lm(sr ~ polym(pop15, ddpi, degree = 2))
summary(g)

## Simulation example 

# y = sin^3(2*pi*x^3) + \epsilon 

# data generation 
myf = function(x) sin(2*pi*x^3)^3
set.seed()
x = seq(0, 1, by = 0.01)
y = myf(x) + 0.1*rnorm(101)
matplot(x, cbind(y, myf(x)), type = "ll")

# polynomials 
g4 = lm(y ~ poly(x, 4))
g12 = lm(y ~ poly(x, 12))
matplot(x, cbind(y, g4$fit, g12$fit), type = "lll")

# regression splines 
  # smooth spline curve fits simulated data very well 
library(splines)
knots = c(0, 0, 0, 0, 0.2, 0.4, 0.5, 0.6, 
          0.7, 0.8, 0.85, 0.9, 1, 1, 1, 1)
bx = splineDesign(knots, x)
gs = lm(y ~ bx)
matplot(x, bx, type = "l")
matplot(x, cbind(y, gs$fit), type = "ll")




