# Environment

library(tidyverse)
library(AER)

# Data

data("NMES1988")

raw <- NMES1988

# Summary table

summary(raw)

# Histogram

ggplot(raw, 
       aes(x = visits,
           fill = medicaid)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5)

# Histogram with facet

ggplot(raw, 
       aes(x = visits,
           fill = medicaid)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5
                 ) +
  facet_wrap(~ gender)

# Density

ggplot(raw, 
       aes(x = visits,
           fill = medicaid)
       ) +
  geom_density(position = "identity",
                 alpha = 0.5
  ) +
  facet_wrap(~ gender)

# Heatmap

ggplot(raw,
       aes(x = income,
           y = visits)
       ) +
  geom_bin2d() +
  facet_wrap(~ gender)
