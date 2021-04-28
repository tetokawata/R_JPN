# Environment

library(tidyverse)
library(AER)
library(estimatr)

# Data

data("CPSSW9298")

raw <- CPSSW9298

# OLS

lm_robust(earnings ~ degree + year + gender + age,
          data = raw) # Regress earnings on degree, year, gender, and age
