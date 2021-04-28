# 環境

library(tidyverse)
library(estimatr)
library(AER)

# データ

data("CPSSW9298")

raw <- CPSSW9298

# 記述統計量

## 記述統計表

summary(raw)

## 作図

### 学歴間賃金分布

ggplot(raw, 
       aes(x = earnings,
           fill = degree)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5)

### 男女別学歴間賃金分布

ggplot(raw, 
       aes(x = earnings,
           fill = degree)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5
                 ) +
  facet_wrap(~gender)