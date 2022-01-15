---
title: "Lab 4 Homework"
author: "Shuyi Bian"
date: "2022-01-15"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**

```r
#getwd()
homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

```
## Rows: 569 Columns: 24
```

```
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (16): taxon, common.name, class, order, family, genus, species, primarym...
## dbl  (8): mean.mass.g, log10.mass, mean.hra.m2, log10.hra, dimension, preyma...
```

```
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**  

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```


```r
glimpse(homerange)
```

```
## Rows: 569
## Columns: 24
## $ taxon                      <chr> "lake fishes", "river fishes", "river fishe…
## $ common.name                <chr> "american eel", "blacktail redhorse", "cent…
## $ class                      <chr> "actinopterygii", "actinopterygii", "actino…
## $ order                      <chr> "anguilliformes", "cypriniformes", "cyprini…
## $ family                     <chr> "anguillidae", "catostomidae", "cyprinidae"…
## $ genus                      <chr> "anguilla", "moxostoma", "campostoma", "cli…
## $ species                    <chr> "rostrata", "poecilura", "anomalum", "fundu…
## $ primarymethod              <chr> "telemetry", "mark-recapture", "mark-recapt…
## $ N                          <chr> "16", NA, "20", "26", "17", "5", "2", "2", …
## $ mean.mass.g                <dbl> 887.00, 562.00, 34.00, 4.00, 4.00, 3525.00,…
## $ log10.mass                 <dbl> 2.9479236, 2.7497363, 1.5314789, 0.6020600,…
## $ alternative.mass.reference <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ mean.hra.m2                <dbl> 282750.00, 282.10, 116.11, 125.50, 87.10, 3…
## $ log10.hra                  <dbl> 5.4514026, 2.4504031, 2.0648696, 2.0986437,…
## $ hra.reference              <chr> "Minns, C. K. 1995. Allometry of home range…
## $ realm                      <chr> "aquatic", "aquatic", "aquatic", "aquatic",…
## $ thermoregulation           <chr> "ectotherm", "ectotherm", "ectotherm", "ect…
## $ locomotion                 <chr> "swimming", "swimming", "swimming", "swimmi…
## $ trophic.guild              <chr> "carnivore", "carnivore", "carnivore", "car…
## $ dimension                  <dbl> 3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3…
## $ preymass                   <dbl> NA, NA, NA, NA, NA, NA, 1.39, NA, NA, NA, N…
## $ log10.preymass             <dbl> NA, NA, NA, NA, NA, NA, 0.1430148, NA, NA, …
## $ PPMR                       <dbl> NA, NA, NA, NA, NA, NA, 530, NA, NA, NA, NA…
## $ prey.size.reference        <chr> NA, NA, NA, NA, NA, NA, "Brose U, et al. 20…
```

**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**  

```r
homerange$taxon <- as.factor(homerange$taxon)
homerange$order <- as.factor(homerange$order)
```

**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.**  

```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```

```r
homerange <- rename(homerange, common_name = "common.name")
```


```r
taxa <- select(homerange, taxon, common_name, class, order, family, genus, species)
```

**5. The variable `taxon` identifies the large, common name groups of the species represented in `homerange`. Make a table the shows the counts for each of these `taxon`.**  

```r
library("janitor")
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

```r
tabyl(homerange, taxon)
```

```
##          taxon   n    percent
##          birds 140 0.24604569
##    lake fishes   9 0.01581722
##        lizards  11 0.01933216
##        mammals 238 0.41827768
##  marine fishes  90 0.15817223
##   river fishes  14 0.02460457
##         snakes  41 0.07205624
##      tortoises  12 0.02108963
##        turtles  14 0.02460457
```

**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  

```r
homerange <- rename(homerange, trophic_guild = "trophic.guild")
```


```r
tabyl(homerange, trophic_guild)
```

```
##  trophic_guild   n   percent
##      carnivore 342 0.6010545
##      herbivore 227 0.3989455
```
There are 342 carnivore species and 227 herbivore species.

**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.**  

```r
homerange <- rename(homerange, mean_hra_m2 = "mean.hra.m2")
```


```r
carnivores <- filter(homerange, trophic_guild == "carnivore")
herbivores <- filter(homerange, trophic_guild == "herbivore")
```

**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**  


```r
herb_hra_mean <- colMeans(herbivores[ ,13], na.rm = T)
carn_hra_mean <- colMeans(carnivores[ ,13], na.rm = T)
herb_hra_mean
```

```
## mean_hra_m2 
##    34137012
```

```r
carn_hra_mean
```

```
## mean_hra_m2 
##    13039918
```
Herbivores have a larger mean.hra.m2.

**9. Make a new dataframe `deer` that is limited to the mean mass, log10 mass, family, genus, and species of deer in the database. The family for deer is cervidae. Arrange the data in descending order by log10 mass. Which is the largest deer? What is its common name?**  

```r
#change name
homerange <- rename(homerange, log10_mass = "log10.mass")
homerange <- rename(homerange, mean_mass_g = "mean.mass.g")
```


```r
#make deerframe
cervidae_family <- filter(homerange, homerange$family == "cervidae")
deer <- select(cervidae_family, mean_mass_g, log10_mass, family, genus, species)
deer <- arrange(deer, desc(log10_mass)) # googled this
deer
```

```
## # A tibble: 12 × 5
##    mean_mass_g log10_mass family   genus      species    
##          <dbl>      <dbl> <chr>    <chr>      <chr>      
##  1     307227.       5.49 cervidae alces      alces      
##  2     234758.       5.37 cervidae cervus     elaphus    
##  3     102059.       5.01 cervidae rangifer   tarandus   
##  4      87884.       4.94 cervidae odocoileus virginianus
##  5      71450.       4.85 cervidae dama       dama       
##  6      62823.       4.80 cervidae axis       axis       
##  7      53864.       4.73 cervidae odocoileus hemionus   
##  8      35000.       4.54 cervidae ozotoceros bezoarticus
##  9      29450.       4.47 cervidae cervus     nippon     
## 10      24050.       4.38 cervidae capreolus  capreolus  
## 11      13500.       4.13 cervidae muntiacus  reevesi    
## 12       7500.       3.88 cervidae pudu       puda
```


```r
#find the largest deer
max_deer_weight <- max(deer$mean_mass_g)
filter(homerange, homerange$mean_mass_g == max_deer_weight & family == "cervidae")
```

```
## # A tibble: 1 × 24
##   taxon   common_name class    order    family genus species primarymethod N    
##   <fct>   <chr>       <chr>    <fct>    <chr>  <chr> <chr>   <chr>         <chr>
## 1 mammals moose       mammalia artioda… cervi… alces alces   telemetry*    <NA> 
## # … with 15 more variables: mean_mass_g <dbl>, log10_mass <dbl>,
## #   alternative.mass.reference <chr>, mean_hra_m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic_guild <chr>, dimension <dbl>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```
The common name of largest deer is moose.

**10. As measured by the data, which snake species has the smallest homerange? Show all of your work, please. Look this species up online and tell me about it!** **Snake is found in taxon column**    

```r
snakes <- filter(homerange, taxon == "snakes") #make snakes dataframe
largest_hra_snake <- filter(snakes, mean_hra_m2 == min(snakes$mean_hra_m2)) #find the smallest one
largest_hra_snake
```

```
## # A tibble: 1 × 24
##   taxon  common_name    class  order  family  genus species  primarymethod N    
##   <fct>  <chr>          <chr>  <fct>  <chr>   <chr> <chr>    <chr>         <chr>
## 1 snakes namaqua dwarf… repti… squam… viperi… bitis schneid… telemetry     11   
## # … with 15 more variables: mean_mass_g <dbl>, log10_mass <dbl>,
## #   alternative.mass.reference <chr>, mean_hra_m2 <dbl>, log10.hra <dbl>,
## #   hra.reference <chr>, realm <chr>, thermoregulation <chr>, locomotion <chr>,
## #   trophic_guild <chr>, dimension <dbl>, preymass <dbl>, log10.preymass <dbl>,
## #   PPMR <dbl>, prey.size.reference <chr>
```
Namaqua dwarf adder has the smallest homerange. The binomial name is Bitis schneideri. It is a venomous snake which is native to a small coastal region between Namibia and South Africa. It is the smallest species in the genus Bitis, and possibly the smallest viper in the world. Although the average total length of it is 18cm to 25cm, the reported largest Namaqua dwarf adder can be 28cm. It's cute.

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
