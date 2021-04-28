# Environment

library(tidyverse)
library(AER)
library(glmnet)
library(ranger)

set.seed(111)

# Data

data("NMES1988")

raw <- NMES1988[1:2000,]

Y <- raw$visits

X <- model.matrix(visits ~ -1 + .,
                  data = raw)

# Group

group <- sample(1:2, 
                length(Y),
                prob = c(8/10,2/10),
                replace = TRUE
                )

# No penalty

fit <- glmnet(y = Y[group == 1],
              x = X[group == 1,],
              lambda = 0)

Y.hat <- predict(fit, X)

1 - mean((Y - Y.hat)[group == 2]^2)/mean((Y[group == 2] - mean(Y[group == 2]))^2)

# LASSO

cv <- cv.glmnet(y = Y[group == 1],
                x = X[group == 1,],
                alpha = 1)

fit <- glmnet(y = Y[group == 1],
              x = X[group == 1,],
              alpha = 1,
              lambda = cv$lambda.min)

Y.hat <- predict(fit, X)

1 - mean((Y - Y.hat)[group == 2]^2)/mean((Y[group == 2] - mean(Y[group == 2]))^2)


# Ridge

cv <- cv.glmnet(y = Y[group == 1],
                x = X[group == 1,],
                alpha = 0)

fit <- glmnet(y = Y[group == 1],
              x = X[group == 1,],
              alpha = 0,
              lambda = cv$lambda.min)

Y.hat <- predict(fit, X)

1 - mean((Y - Y.hat)[group == 2]^2)/mean((Y[group == 2] - mean(Y[group == 2]))^2)

# Random Forest

fit <- ranger(y = Y[group == 1],
              x = X[group == 1,],
              num.trees = 2000)

Y.hat <- predict(fit,X)$predictions

1 - mean((Y - Y.hat)[group == 2]^2)/mean((Y[group == 2] - mean(Y[group == 2]))^2)
