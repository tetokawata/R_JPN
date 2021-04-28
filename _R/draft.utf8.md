---
title: "R Notebook"
output:
  pdf_document:
    toc: yes
  html_notebook:
    toc: yes
    toc_float: yes
---

# 環境


```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.1.1     v dplyr   1.0.5
## v tidyr   1.1.3     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## Warning: package 'ggplot2' was built under R version 4.0.3
```

```
## Warning: package 'tidyr' was built under R version 4.0.5
```

```
## Warning: package 'readr' was built under R version 4.0.3
```

```
## Warning: package 'dplyr' was built under R version 4.0.5
```

```
## Warning: package 'forcats' was built under R version 4.0.3
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(estimatr)
```

```
## Warning: package 'estimatr' was built under R version 4.0.3
```

```r
library(AER)
```

```
## Warning: package 'AER' was built under R version 4.0.3
```

```
## Loading required package: car
```

```
## Warning: package 'car' was built under R version 4.0.3
```

```
## Loading required package: carData
```

```
## Warning: package 'carData' was built under R version 4.0.3
```

```
## 
## Attaching package: 'car'
```

```
## The following object is masked from 'package:dplyr':
## 
##     recode
```

```
## The following object is masked from 'package:purrr':
## 
##     some
```

```
## Loading required package: lmtest
```

```
## Loading required package: zoo
```

```
## Warning: package 'zoo' was built under R version 4.0.5
```

```
## 
## Attaching package: 'zoo'
```

```
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```

```
## Loading required package: sandwich
```

```
## Warning: package 'sandwich' was built under R version 4.0.3
```

```
## Loading required package: survival
```

```
## Warning: package 'survival' was built under R version 4.0.5
```


# データ


```r
data("CPSSW9298")

raw <- CPSSW9298
```

# 記述統計量

## 記述統計表


```r
summary(raw)
```

```
##    year         earnings             degree        gender          age       
##  1992:7590   Min.   : 1.840   highschool:7936   male  :7815   Min.   :25.00  
##  1998:5911   1st Qu.: 8.173   bachelor  :5565   female:5686   1st Qu.:27.00  
##              Median :11.538                                   Median :30.00  
##              Mean   :12.663                                   Mean   :29.71  
##              3rd Qu.:15.865                                   3rd Qu.:32.00  
##              Max.   :49.451                                   Max.   :34.00
```

## 作図

### 学歴間賃金分布


```r
ggplot(raw, 
       aes(x = earnings,
           fill = degree)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5)
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](draft_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 

### 男女別学歴間賃金分布


```r
ggplot(raw, 
       aes(x = earnings,
           fill = degree)
       ) +
  geom_histogram(position = "identity",
                 alpha = 0.5) +
  facet_wrap(~gender)
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

![](draft_files/figure-latex/unnamed-chunk-5-1.pdf)<!-- --> 
