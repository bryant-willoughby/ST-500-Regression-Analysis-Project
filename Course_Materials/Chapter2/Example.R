######
## Chapter 2: Estimation 
## Example Code 
## Bryant Willoughby 
######

### Day 1

## Load library 
# install.packages("faraway")
library(faraway)

# Read in the data
data(pima) # loads specified data sets 
pima

# Explore data 
help(pima)

# summary stats 
dim(pima) #dimension of data 
summary(pima) #numerical summaries 

# missing values 
sort(pima$diastolic)

pima$diastolic[pima$diastolic == 0] = NA
pima$glucose[pima$glucose == 0] = NA
pima$triceps[pima$triceps == 0] = NA
pima$insulin[pima$insulin == 0] = NA
pima$bmi[pima$bmi == 0] = NA


# categorical variabvle 
pima$test = factor(pima$test)
summary(pima$test)
levels(pima$test) = c("negative", "positive")
summary(pima$test)

# new summary
summary(pima)

# individual summary functions 
mean(pima$diastolic, na.rm = T)
median(pima$diastolic, na.rm = T)
range(pima$diastolic, na.rm = T)
quantile(pima$diastolic, na.rm = T)

# Graphical summaries (one var)
hist(pima$diastolic)
boxplot(pima$diastolic)

# Graphical summaries (two vars) 
plot(pima$diastolic, pima$diabetes) #scatterplot
plot(pima$test, pima$bmi) #boxplots across levels 

# scatterplot matrix 
pairs(pima)

### Day 2
library(faraway)

## Galapagos island example
data(gala)
gala

# EDA, matrix construction, and least squares estimate
dim(gala) #30x7
n = dim(gala)[1]
p = dim(gala)[2] - 2
x = cbind(1, as.matrix(gala[, 3:7])) #design matrix
dim(x) # 30x6
xtx = t(x) %*% x 
xtxi = solve(xtx) #inverse 
beta = xtxi %*% t(x) %*% gala[,1] #least squares estimate
beta

# Residual sum of squares
rss = sum((gala[,1] - x %*% beta)^2) #element-wise sum
sigma2 = rss / (n - (p + 1)) #estimated variance
sigma = sqrt(sigma2) #estimated SD 
sigma #RMSE 

# fit with lm() function 
temp = lm(Species ~ Area + Elevation + Nearest + 
            Scruz + Adjacent, data = gala)
summary(temp)











