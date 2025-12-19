######
## Chapter 10: Variable Selection 
## Example Code 
## Bryant Willoughby 
###### 


## Life Expectancy Example (cont)
data(state)

# reassemble the data (add row names)
  # Area largest p-value
statedata = data.frame(state.x77, row.names = state.abb)
g = lm(Life.Exp ~ .,  data = statedata)
summary(g)

# backward elimination - drop largest p-value 
g = update(g, . ~ . - Area)
summary(g)

# continue dropping 
g = update(g, . ~ . - Illiteracy)
summary(g)

# continue dropping 
g = update(g, . ~ . - Income)
summary(g)

# borderline case; would keep for prediction; illustrate dropping 
g = update(g, . ~ ., - Population)
summary(g)

# cannot conclude other predictors have no effect on response, e.g. Illiteracy
  # still appears significant w/ new fitted model (not obtained from above process)
summary(lm(Life.Exp ~ Illiteracy + Murder + Frost, statedata))

## AIC 
g = lm(Life.Exp ~ ., data = statedata) 
step(g) #k = 2 default 

## Adjusted-R^2 
  # using best subset selection 
library(leaps)
b = regsubsets(Life.Exp ~ ., data = statedata)
summary(b)

# plot adj R^2 against p + 1 
rs = summary(b)
plot(2:8, rs$adjr2, xlab = "No. of Parameters", 
     ylab = "Adjusted Rsq")

# select model with largest adjusted R^2
which.max(rs$adjr2)

## Mallows Cp 
b = regsubsets(Life.Exp ~ ., data = statedata)
summary(b)
which.min(rs$cp)

plot(2:8, rs$cp, xlab = "No. of Parameters", 
     ylab = "Cp")
abline(0, 1)









