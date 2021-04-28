# Environment

library(tidyverse)
library(estimatr)
library(AER)

# Data

data("CPSSW9298")

raw <- CPSSW9298

# Summary table

summary(raw)

# Histogram

ggplot(raw, 
       aes(x = earnings,
           fill = degree)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5)

# Histogram with facet

ggplot(raw, 
       aes(x = earnings,
           fill = degree)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5
                 ) +
  facet_wrap(~ gender)

# Density

ggplot(raw, 
       aes(x = earnings,
           fill = degree)
       ) +
  geom_density(position = "identity",
                 alpha = 0.5
  ) +
  facet_wrap(~ gender)

# Heatmap

ggplot(raw,
       aes(x = age,
           y = earnings)
       ) +
  geom_bin2d() +
  facet_wrap(~ gender)
