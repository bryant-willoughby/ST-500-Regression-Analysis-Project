######
## Chapter 3: Inference 
## Example Code 
## Bryant Willoughby 
######

# load data 
library(faraway)
help(savings)
data(savings)
savings <- savings
head(savings)

# fit model 
result <- lm(sr ~ ., savings)
summary(result)

# F-test (General Linear Test)
h0 <- lm(sr ~ pop15 + dpi + ddpi, savings) #reduced model
h0a <- lm(sr ~ ., savings) #full model
anova(h0, h0a)

# Testing a pair
h0 <- lm(sr ~ pop15 + ddpi, savings) 
h0a <- lm(sr ~ pop15 + pop75 + dpi + ddpi, savings) 
anova(h0, h0a)

# Testing a subspace; testing \beta_1 = \beta_2  
h0 <- lm(sr ~ I(pop15 + pop75) + dpi + ddpi, savings)
h0a <- lm(sr ~ pop15 + pop75 + dpi + ddpi, savings)
anova(h0, h0a)

# Testing a subspace; tseting \beta_4 = 0.5
h0 <- lm(sr ~ pop15 + pop75 + dpi + offset(0.5*ddpi), savings)
h0a <- lm(sr ~ pop15 + pop75 + dpi + ddpi, savings) 
anova(h0, h0a)

# Confidence intervals; default two-sided 95%
result <- lm(sr ~ pop15 + pop75 + dpi + ddpi, savings) 
summary(result)
conf <- confint(result); print(conf)

# simultaneous confidence region 
library(ellipse)
#plot confience region 
plot(ellipse(result, c('pop15', 'pop75')), 
     type = 'l', xlim = c(-1,0))
#add estimates to the plot 
points(result$coef['pop15'], result$coef['pop75'], pch=18)
#add origin to the plot 
points(0,0,pch=1)
#add confidence interval for pop15
abline(v=conf['pop15',], lty=2)
#add confidence interval for pop75
abline(h=conf['pop75',], lty=2)

# correlation between pop15 and pop75
plot(x=savings$pop15, y=savings$pop75)
cor(savings$pop15, savings$pop75) #approx -0.91





