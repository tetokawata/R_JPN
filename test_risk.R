library(tidyverse)
library(AER)
library(SuperLearner)
library(AIPW)
library(future.apply)
library(recipes)
library(estimatr)

data("NMES1988")

raw <- na.omit(NMES1988)

set.seed(123)

Y <- raw$emergency

D <- if_else(raw$insurance == "yes",1,0)

X <- recipe(~ .,
            select(raw,-insurance,-emergency)) |> 
  step_other(all_nominal_predictors(),
             other = "Others") |> 
  step_unknown(all_nominal_predictors()) |> 
  step_poly(all_numeric_predictors()) |> 
  step_indicate_na(all_numeric_predictors()) |> 
  step_impute_median(all_numeric_predictors()) |> 
  step_dummy(all_nominal_predictors()) |> 
  step_nzv(all_predictors()) |> 
  step_corr(all_predictors()) |> 
  step_lincomb(all_predictors()) |> 
  prep() |> 
  bake(raw)

group <- sample(1:2, nrow(raw), replace = TRUE)

plan(multisession, workers = 8, gc = T)
algorism <- AIPW$new(
  Y = Y[group == 1],
  A = D[group == 1],
  W = X[group == 1,],
  Q.SL.library = c(
    "SL.lm",
    "SL.ranger",
    "SL.glmnet"
  ),
  g.SL.library = c(
    "SL.lm",
    "SL.ranger",
    "SL.glmnet"
  )
)

algorism$stratified_fit()$summary()

aipw <- algorism$obs_est$aipw_eif1 -  algorism$obs_est$aipw_eif0

signal <-
  lm(aipw ~ .,
     tibble(Y = aipw,
            X[group == 1,])) |> 
  predict(X)

fit <- SuperLearner(Y = aipw,
                    X = X[group == 1,],
                    SL.library = c("SL.lm",
                                   "SL.mean",
                                   "SL.glmnet",
                                   "SL.ranger"))

fit

plan(multisession, workers = 8, gc = T)
algorism <- AIPW$new(
  Y = Y[group == 2],
  A = D[group == 2],
  W = X[group == 2,],
  Q.SL.library = c(
    "SL.lm",
    "SL.ranger",
    "SL.glmnet"
  ),
  g.SL.library = c(
    "SL.lm",
    "SL.ranger",
    "SL.glmnet"
  )
)

algorism$stratified_fit()$summary()

aipw <- algorism$obs_est$aipw_eif1 -  algorism$obs_est$aipw_eif0

est_risk <- function(a){
  beta <- quantile(signal[group == 1], probs = a)
  score <- beta + (1/a)*if_else(signal[group == 2] <= beta,1,0)*(aipw - beta)
  lm_robust(score ~ 1) |> 
    tidy() |> 
    mutate(a = a)
}

result <- map_dfr(seq(0.1,1,0.01),est_risk)

result |> 
  ggplot(aes(x = a,
             y = estimate,
             ymin = conf.low,
             ymax = conf.high)) + 
  geom_ribbon()
