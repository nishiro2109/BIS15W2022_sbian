---
title: "Lab 11 Homework"
author: "Shuyi Bian"
date: "2022-02-15"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above. For any included plots, make sure they are clearly labeled. You are free to use any plot type that you feel best communicates the results of your analysis.  

**In this homework, you should make use of the aesthetics you have learned. It's OK to be flashy!**

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```


```r
options(scipen=999) 
```

## Resources
The idea for this assignment came from [Rebecca Barter's](http://www.rebeccabarter.com/blog/2017-11-17-ggplot2_tutorial/) ggplot tutorial so if you get stuck this is a good place to have a look.  

## Gapminder
For this assignment, we are going to use the dataset [gapminder](https://cran.r-project.org/web/packages/gapminder/index.html). Gapminder includes information about economics, population, and life expectancy from countries all over the world. You will need to install it before use. This is the same data that we will use for midterm 2 so this is good practice.

```r
#install.packages("gapminder")
library("gapminder")
```

## Questions
The questions below are open-ended and have many possible solutions. Your approach should, where appropriate, include numerical summaries and visuals. Be creative; assume you are building an analysis that you would ultimately present to an audience of stakeholders. Feel free to try out different `geoms` if they more clearly present your results.  

**1. Use the function(s) of your choice to get an idea of the overall structure of the data frame, including its dimensions, column names, variable classes, etc. As part of this, determine how NA's are treated in the data.**  

```r
summary(gapminder)
```

```
##         country        continent        year         lifeExp     
##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
##  Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
##  Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
##  Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
##  Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
##  Australia  :  12                  Max.   :2007   Max.   :82.60  
##  (Other)    :1632                                                
##       pop               gdpPercap       
##  Min.   :     60011   Min.   :   241.2  
##  1st Qu.:   2793664   1st Qu.:  1202.1  
##  Median :   7023596   Median :  3531.8  
##  Mean   :  29601212   Mean   :  7215.3  
##  3rd Qu.:  19585222   3rd Qu.:  9325.5  
##  Max.   :1318683096   Max.   :113523.1  
## 
```

```r
naniar::miss_var_summary(gapminder)
```

```
## # A tibble: 6 × 3
##   variable  n_miss pct_miss
##   <chr>      <int>    <dbl>
## 1 country        0        0
## 2 continent      0        0
## 3 year           0        0
## 4 lifeExp        0        0
## 5 pop            0        0
## 6 gdpPercap      0        0
```

```r
glimpse(gapminder)
```

```
## Rows: 1,704
## Columns: 6
## $ country   <fct> "Afghanistan", "Afghanistan", "Afghanistan", "Afghanistan", …
## $ continent <fct> Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, Asia, …
## $ year      <int> 1952, 1957, 1962, 1967, 1972, 1977, 1982, 1987, 1992, 1997, …
## $ lifeExp   <dbl> 28.801, 30.332, 31.997, 34.020, 36.088, 38.438, 39.854, 40.8…
## $ pop       <int> 8425333, 9240934, 10267083, 11537966, 13079460, 14880372, 12…
## $ gdpPercap <dbl> 779.4453, 820.8530, 853.1007, 836.1971, 739.9811, 786.1134, …
```

**2. Among the interesting variables in gapminder is life expectancy. How has global life expectancy changed between 1952 and 2007?**

```r
gapminder %>% 
  group_by(year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x=as.factor(year), y=mean_lifeExp))+
  geom_col()+
  theme_linedraw()+
  labs(title = "Global Life Expectancy Change",
       x=NULL,
       y="mean life expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

**3. How do the distributions of life expectancy compare for the years 1952 and 2007?**

```r
gapminder %>% 
  filter(year == "1952" | year == "2007") %>% 
  group_by(year) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x=as.factor(year), y=mean_lifeExp))+
  geom_col()+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "1952 and 2007 Life Expectancy Change",
       x=NULL,
       y="life expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

**4. Your answer above doesn't tell the whole story since life expectancy varies by region. Make a summary that shows the min, mean, and max life expectancy by continent for all years represented in the data.**

```r
gapminder %>% 
  ggplot(aes(x=as.factor(year), y=lifeExp, fill = continent))+
  geom_boxplot()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "Life Expectancy by Continents",
       x=NULL,
       y="life expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

**5. How has life expectancy changed between 1952-2007 for each continent?**

```r
gapminder %>% 
  group_by(year, continent) %>% 
  summarize(mean_lifeExp = mean(lifeExp)) %>% 
  ggplot(aes(x=year, y=mean_lifeExp, color=continent))+
  geom_line()+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "Mean Life Expectancy Change by Continents",
       x=NULL,
       y="%life expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

```
## `summarise()` has grouped output by 'year'. You can override using the
## `.groups` argument.
```

![](lab11_hw_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

**6. We are interested in the relationship between per capita GDP and life expectancy; i.e. does having more money help you live longer?**
Yes!

```r
gapminder %>% 
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent))+
  geom_point()+
  labs(title = "Per Capta GDP vs. Life Expectancy",
       x="per capta GDP",
       y="life expectancy")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->


**7. Which countries have had the largest population growth since 1952?**

```r
gapminder %>% 
  filter(year == "1952" | year == "2007") %>% 
  group_by(continent) %>% 
  summarise(pop_growth = sum(max(pop) - sum(min(pop)))) %>% #I don't know how to pick a specific value so I use a dumb method
  ggplot(aes(x=reorder(continent, pop_growth), y=pop_growth, fill=continent))+
  geom_col()+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "Population Growth by Continent",
       x="continent",
       y="population growth")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

**8. Use your results from the question above to plot population growth for the top five countries since 1952.**

```r
gapminder %>% 
  group_by(country) %>% 
  summarise(pop_growth = sum(max(pop) - sum(min(pop)))) %>% 
  arrange(desc(pop_growth)) %>% 
  top_n(5, pop_growth) %>% 
  ggplot(aes(x=reorder(country, pop_growth), y=pop_growth, fill=country))+
  geom_col()+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "Top 5 Population Growth Countries",
       x="country",
       y="population growth")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

**9. How does per-capita GDP growth compare between these same five countries?**

```r
gapminder %>% 
  filter(country == "China"|country == "Brazil"|country == "Indonesia"|country == "India"|country == "United States") %>% 
  group_by(country) %>% 
  summarise(gdp_growth = max(gdpPercap)-min(gdpPercap)) %>% 
  ggplot(aes(x=reorder(country,gdp_growth), y=gdp_growth, fill=country))+
  geom_col()+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "Top 5 Population Growth Countries' GDP Growth",
       x="country",
       y="GDP growth")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

**10. Make one plot of your choice that uses faceting!**
I want to find top 5 gdp growth countries' life expectancy change.


```r
gapminder %>% 
  group_by(country) %>% 
  summarise(gdp_growth = sum(max(gdpPercap) - sum(min(gdpPercap)))) %>% 
  arrange(desc(gdp_growth)) %>% 
  top_n(5, gdp_growth)
```

```
## # A tibble: 5 × 2
##   country          gdp_growth
##   <fct>                 <dbl>
## 1 Kuwait               85405.
## 2 Singapore            44828.
## 3 Norway               39262.
## 4 Hong Kong, China     36671.
## 5 Ireland              35466.
```

```r
gapminder %>% 
  filter(country == "Kuwait"|country == "Singapore"|country == "Norway"|country == "Hongkong, China"|country == "Ireland") %>% 
  ggplot(aes(x=as.factor(year), y=lifeExp, fill=country))+
  geom_col()+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "Top 5 GDP Growth Countries' Life Expactancy Change",
       x="year",
       y="life expactancy growth")+
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))
```

![](lab11_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences. 
