# Environment

library(tidyverse)
library(AER)
library(estimatr)

# Data

data("NMES1988")

raw <- NMES1988

# OLS

lm_robust(visits ~ income + age + gender + school,
          data = raw) # Regress earnings on degree, year, gender, and age
