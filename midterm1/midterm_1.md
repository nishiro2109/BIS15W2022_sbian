---
title: "Midterm 1"
author: "Shuyi Bian"
date: "2022-01-25"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. You may use any resources to answer these questions (including each other), but you may not post questions to Open Stacks or external help sites. There are 15 total questions, each is worth 2 points.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

This exam is due by 12:00p on Thursday, January 27.  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.7
## ✓ tidyr   1.1.4     ✓ stringr 1.4.0
## ✓ readr   2.1.1     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(janitor)
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Questions  
Wikipedia's definition of [data science](https://en.wikipedia.org/wiki/Data_science): "Data science is an interdisciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from noisy, structured and unstructured data, and apply knowledge and actionable insights from data across a broad range of application domains."  

1. (2 points) Consider the definition of data science above. Although we are only part-way through the quarter, what specific elements of data science do you feel we have practiced? Provide at least one specific example.  
I think we already learn how to "extract knowledge and insights from noisy, structured and unstructured data" during the class. Some data frame are unstructured, for example, researchers might fill in -999 in data or just leave them in blank, and we have to change them to NA and make it easier to process data. Also, we practiced more on how to process tidy and clean data. For example, we know how to make an overview by glimpse(); in a data frame, we can use select() and filter() to select data we are interested in.

2. (2 points) What is the most helpful or interesting thing you have learned so far in BIS 15L? What is something that you think needs more work or practice?  
The most helpful thing must be using select() and filter(). Select() enables me to select specific columns I am interested in from thousands of columns; filter() is a good helper when I want to find specific values in data frame.
I think I need to practice more on how to use group_by() and summarize(). They are also useful but I don't have a clear picture about what I will get when I am using group_by() and summarize(). With more practice maybe I won't need luck and intuition but relying more on my logic.

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.

```r
elephants <- readr::read_csv(file = "data/ElephantsMF.csv")
```

```
## Rows: 288 Columns: 3
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): Sex
## dbl (2): Age, Height
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17, 1…
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204.00,…
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M"…
```

4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.

```r
names(elephants)
```

```
## [1] "Age"    "Height" "Sex"
```


```r
elephants <- rename(elephants, age = "Age", height = "Height", sex = "Sex" )
```


```r
elephants$sex <- as.factor(elephants$sex)
```


```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17, 1…
## $ height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204.00,…
## $ sex    <fct> M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, M, …
```

5. (2 points) How many male and female elephants are represented in the data?

```r
elephants %>% 
  tabyl(sex)
```

```
##  sex   n   percent
##    F 150 0.5208333
##    M 138 0.4791667
```
There are 138 male elephants and 150 female elephants in the data.

6. (2 points) What is the average age all elephants in the data?

```r
mean(elephants$age, na.rm=T)
```

```
## [1] 10.97132
```
Average age is 10.97132.

7. (2 points) How does the average age and height of elephants compare by sex?

```r
elephants %>% 
  group_by(sex) %>% 
  summarize(avg_age = mean(age, na.rm=T),
            avg_height = mean(height, na.rm=T))
```

```
## # A tibble: 2 × 3
##   sex   avg_age avg_height
##   <fct>   <dbl>      <dbl>
## 1 F       12.8        190.
## 2 M        8.95       185.
```

8. (2 points) How does the average height of elephants compare by sex for individuals over 20 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.  

```r
elephants %>% 
  filter(age > 20) %>% 
  group_by(sex) %>% 
  summarize(avg_height_above_20 = mean(height, na.rm=T),
            max_height_above_20 = max(height),
            min_height_above_20 = min(height),
            n=n())
```

```
## # A tibble: 2 × 5
##   sex   avg_height_above_20 max_height_above_20 min_height_above_20     n
##   <fct>               <dbl>               <dbl>               <dbl> <int>
## 1 F                    232.                278.                193.    37
## 2 M                    270.                304.                229.    13
```

For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.

```r
ivindo <- readr::read_csv(file = "data/IvindoData_DryadVersion.csv")
```

```
## Rows: 24 Columns: 26
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (2): HuntCat, LandUse
## dbl (24): TransectID, Distance, NumHouseholds, Veg_Rich, Veg_Stems, Veg_lian...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
glimpse(ivindo)
```

```
## Rows: 24
## Columns: 26
## $ TransectID              <dbl> 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 13, 14, 15, 16, …
## $ Distance                <dbl> 7.14, 17.31, 18.32, 20.85, 15.95, 17.47, 24.06…
## $ HuntCat                 <chr> "Moderate", "None", "None", "None", "None", "N…
## $ NumHouseholds           <dbl> 54, 54, 29, 29, 29, 29, 29, 54, 25, 73, 46, 56…
## $ LandUse                 <chr> "Park", "Park", "Park", "Logging", "Park", "Pa…
## $ Veg_Rich                <dbl> 16.67, 15.75, 16.88, 12.44, 17.13, 16.50, 14.7…
## $ Veg_Stems               <dbl> 31.20, 37.44, 32.33, 29.39, 36.00, 29.22, 31.2…
## $ Veg_liana               <dbl> 5.78, 13.25, 4.75, 9.78, 13.25, 12.88, 8.38, 8…
## $ Veg_DBH                 <dbl> 49.57, 34.59, 42.82, 36.62, 41.52, 44.07, 51.2…
## $ Veg_Canopy              <dbl> 3.78, 3.75, 3.43, 3.75, 3.88, 2.50, 4.00, 4.00…
## $ Veg_Understory          <dbl> 2.89, 3.88, 3.00, 2.75, 3.25, 3.00, 2.38, 2.71…
## $ RA_Apes                 <dbl> 1.87, 0.00, 4.49, 12.93, 0.00, 2.48, 3.78, 6.1…
## $ RA_Birds                <dbl> 52.66, 52.17, 37.44, 59.29, 52.62, 38.64, 42.6…
## $ RA_Elephant             <dbl> 0.00, 0.86, 1.33, 0.56, 1.00, 0.00, 1.11, 0.43…
## $ RA_Monkeys              <dbl> 38.59, 28.53, 41.82, 19.85, 41.34, 43.29, 46.2…
## $ RA_Rodent               <dbl> 4.22, 6.04, 1.06, 3.66, 2.52, 1.83, 3.10, 1.26…
## $ RA_Ungulate             <dbl> 2.66, 12.41, 13.86, 3.71, 2.53, 13.75, 3.10, 8…
## $ Rich_AllSpecies         <dbl> 22, 20, 22, 19, 20, 22, 23, 19, 19, 19, 21, 22…
## $ Evenness_AllSpecies     <dbl> 0.793, 0.773, 0.740, 0.681, 0.811, 0.786, 0.81…
## $ Diversity_AllSpecies    <dbl> 2.452, 2.314, 2.288, 2.006, 2.431, 2.429, 2.56…
## $ Rich_BirdSpecies        <dbl> 11, 10, 11, 8, 8, 10, 11, 11, 11, 9, 11, 11, 1…
## $ Evenness_BirdSpecies    <dbl> 0.732, 0.704, 0.688, 0.559, 0.799, 0.771, 0.80…
## $ Diversity_BirdSpecies   <dbl> 1.756, 1.620, 1.649, 1.162, 1.660, 1.775, 1.92…
## $ Rich_MammalSpecies      <dbl> 11, 10, 11, 11, 12, 12, 12, 8, 8, 10, 10, 11, …
## $ Evenness_MammalSpecies  <dbl> 0.736, 0.705, 0.650, 0.619, 0.736, 0.694, 0.77…
## $ Diversity_MammalSpecies <dbl> 1.764, 1.624, 1.558, 1.484, 1.829, 1.725, 1.92…
```


```r
ivindo$HuntCat <- as.factor(ivindo$HuntCat)
ivindo$LandUse <- as.factor(ivindo$LandUse)
```

10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?

```r
ivindo %>% 
  filter(HuntCat == "High" | HuntCat == "Moderate") %>% 
  group_by(HuntCat) %>% 
  summarize(avg_diversity_birds = mean(Diversity_BirdSpecies, na.rm=T),
            avg_diversity_mammals = mean(Diversity_MammalSpecies, na.rm=T),
            n=n())
```

```
## # A tibble: 2 × 4
##   HuntCat  avg_diversity_birds avg_diversity_mammals     n
##   <fct>                  <dbl>                 <dbl> <int>
## 1 High                    1.66                  1.74     7
## 2 Moderate                1.62                  1.68     8
```

11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 3km from a village to sites that are greater than 25km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.  

```r
ivindo %>% 
  filter(Distance < 3) %>% # distance less than 3km
  summarize(across(starts_with("RA"), mean, na.rm=T),
            sites_number=n())
```

```
## # A tibble: 1 × 7
##   RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate sites_number
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>        <int>
## 1    0.12     76.6       0.145       17.3      3.90        1.87            2
```

```r
ivindo %>% 
  filter(Distance > 25) %>% #distance greater than 25km
  summarize(across(starts_with("RA"), mean, na.rm=T),
            sites_number=n())
```

```
## # A tibble: 1 × 7
##   RA_Apes RA_Birds RA_Elephant RA_Monkeys RA_Rodent RA_Ungulate sites_number
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>        <int>
## 1    4.91     31.6           0       54.1      1.29        8.12            1
```

12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`

I want to analyse the mean diversity, richness, and evenness of bird species in park and logging places.


```r
ivindo %>% 
  filter(LandUse == "Park" | LandUse == "Logging") %>% 
  group_by(LandUse) %>% 
  summarize(mean_diversity_bird = mean(Diversity_BirdSpecies, na.rm=T),
            mean_rich_bird = mean(Rich_BirdSpecies, na.rm=T),
            mean_evenness_bird = mean(Evenness_BirdSpecies, na.rm=T),
            n=n())
```

```
## # A tibble: 2 × 5
##   LandUse mean_diversity_bird mean_rich_bird mean_evenness_bird     n
##   <fct>                 <dbl>          <dbl>              <dbl> <int>
## 1 Logging                1.56           10.2              0.671    13
## 2 Park                   1.77           10.4              0.758     7
```

