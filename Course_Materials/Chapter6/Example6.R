######
## Chapter 6: Diagnostics 
## Example Code 
## Bryant Willoughby 
######

#load in data and fit model 
library(faraway)
data(savings)
result <- lm(sr ~ pop15 + pop75 + dpi + ddpi, savings)
summary(result)

# constant variance checking 

#plot residuals vs fitted values 
plot(result$fitted, result$residual, 
     xlab = "Fitted", ylab = "Residuals")
abline(h = 0)

#plot absolute values of residuals vs fitted values 
plot(result$fitted, abs(result$residual), 
     xlab = "Fitted", ylab = "|Residuals|")
  #p=0.09 -> not evidence to suggest non-constant variance at 0.05 level 
summary(lm(abs(result$residual) ~ result$fitted)) 

# normal assumption checking (qq-plot)

#qq-plot
qqnorm(result$residual, ylab = "Residuals")
qqline(result$residual)

#histogram
hist(result$residual, xlab = "Residuals")

#shapiro-wilk test for normality 
shapiro.test(result$residual) #no evidence for non-normality 

#half-normal plot; identify influential points 
halfnorm(lm.influence(result)$hat, nlab = 2, ylab = "Leverages")
savings[c(44,49),]

#(internally) studentized residuals 
result.s <- summary(result) 
sigma.s <- result.s$sig
hat.s <- lm.influence(result)$hat
stud.res <- result$residual / (sigma.s * sqrt(1 - hat.s))
plot(stud.res, result$residuals, 
     xlab = "Studentized Residuals", ylab = "Raw Residuals")

#(externally) studentized residuals 
ti <- rstudent(result)
max(abs(ti))
which(ti == max(abs(ti)))
2*(1 - pt(max(abs(ti)), df = 50 - 5 - 1)) #compare to alpha/n, i.e. 
0.05/50


#compute Cook's distance 
cook <- cooks.distance(result)
halfnorm(cook, nlab = 3, ylab = "Cook's distance")
savings[c(46, 23, 49),]

#fit model w/o Libya (highest cook's distance points)
result.libya <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = savings, 
                   subset = (cook < max(cook)))
summary(result.libya)

#compute change in coefficients 
result.inf <- lm.influence(result)
plot(result.inf$coef[,2], result.inf$coef[,3], 
     xlab = "Change in beta2", 
     ylab = "Change in beta3")
savings[c(21, 23, 49),]

# Label selected points 21, 23, 49
idx <- c(21, 23, 49)
x <- result.inf$coef[idx, 2]
y <- result.inf$coef[idx, 3]
points(x, y, pch = 19, col = "blue")
labs <- as.character(idx)# or: as.character(idx) if no row names
text(x, y, labels = labs, pos = 1, cex = 0.8, col = "blue", offset = 0.4)


#partial regression plot 
  #looking for any deviation from linearity, outliers, influential points, etc. 
delta <- residuals(lm(sr ~ pop75 + dpi + ddpi, data = savings))
gamma <- residuals(lm(pop15 ~ pop75 + dpi + ddpi, data = savings))
plot(gamma, delta, xlab = "Pop15 Residuals")
temp <- lm(delta ~ gamma)
abline(reg = temp)

#partial residual plot 
  #checking for any unusual patterns 
  #notice: two distinct groups according to pop15
plot(savings$pop15, result$residuals + coef(result)['pop15']*savings$pop15, xlab = "Pop15", 
     ylab = "Savings (adjusted for pop15)")
abline(a = 0, b = coef(result)['pop15'])

#plot residuals vs. predictors 
plot(savings$pop15, result$residual, 
     xlab = "Population under 15", 
     ylab = "Residuals")
plot(savings$pop75, result$residual, 
     xlab = "Population over 75", 
     ylab = "Residuals")

#two separate regressions on two groups 
temp1 <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = savings, 
            subset = (pop15 > 35))
summary(temp1) #all vars insignificant 
temp2 <- lm(sr ~ ., data = savings, subset = (pop15 < 35))
summary(temp2) #two significant variables












