---
title: "Lab 14 HW"
output: 
  html_document: 
    keep_md: yes
author: "Shuyi Bian"
date: '2022-02-28'
---


### Load the Libraries

```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.8
## ✓ tidyr   1.2.0     ✓ stringr 1.4.0
## ✓ readr   2.1.2     ✓ forcats 0.5.1
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

```r
library("palmerpenguins")

#install.packages("ggVennDiagram")
library(ggVennDiagram)
library(RColorBrewer)

#install.packages("ggworldcloud")
library(ggwordcloud)


options(scipen=999) #cancels the use of scientific notation for the session
```


### Data

```r
superhero_info <- readr::read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- readr::read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
beachbugs_long <- readr::read_csv("data/beachbugs_long.csv")
```

```
## Rows: 66 Columns: 3
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): site
## dbl (2): year, buglevels
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

### 1. 
Clean up the column names (no capitals, not spaces) of `superhero_info`, then use 2 functions to remind yourself of structure of the `superhero_info` data set.


```r
superhero_info <- clean_names(superhero_info)
```


```r
head(superhero_info)
```

```
## # A tibble: 6 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 A-Bomb Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
## 2 Abe S… Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
## 3 Abin … Male   blue      Unga… No Hair       185 DC Comics red        good     
## 4 Abomi… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
## 5 Abrax… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
## 6 Absor… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
## # … with 1 more variable: weight <dbl>
```

```r
glimpse(superhero_info)
```

```
## Rows: 734
## Columns: 10
## $ name       <chr> "A-Bomb", "Abe Sapien", "Abin Sur", "Abomination", "Abraxas…
## $ gender     <chr> "Male", "Male", "Male", "Male", "Male", "Male", "Male", "Ma…
## $ eye_color  <chr> "yellow", "blue", "blue", "green", "blue", "blue", "blue", …
## $ race       <chr> "Human", "Icthyo Sapien", "Ungaran", "Human / Radiation", "…
## $ hair_color <chr> "No Hair", "No Hair", "No Hair", "No Hair", "Black", "No Ha…
## $ height     <dbl> 203, 191, 185, 203, NA, 193, NA, 185, 173, 178, 191, 188, 1…
## $ publisher  <chr> "Marvel Comics", "Dark Horse Comics", "DC Comics", "Marvel …
## $ skin_color <chr> NA, "blue", "red", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ alignment  <chr> "good", "good", "good", "bad", "bad", "bad", "good", "good"…
## $ weight     <dbl> 441, 65, 90, 441, NA, 122, NA, 88, 61, 81, 104, 108, 90, 90…
```

### 2.
Are bad guys bigger? Make box-plots of weight by `alignment` (alignment on the x-axis).

```r
superhero_info %>% 
  filter(alignment != "NA") %>% 
  ggplot(aes(x = alignment, y = weight, fill = alignment))+
  geom_boxplot(na.rm = TRUE)+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(x="alignment",
       y="weight")
```

![](lab14_hw_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

### 3. 
Now, make a violin plot of weight by `alignment` (alignment on the x-axis). Add some color!
  What information can you observe in the violin plot that was not visible in the boxplot?

```r
superhero_info %>% 
  filter(alignment != "NA") %>% 
  ggplot(aes(x = alignment, y = weight, fill = alignment))+
  geom_violin(na.rm = TRUE)+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(x="alignment",
       y="weight")
```

![](lab14_hw_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
#I can see the distribution of weight.
```

### 4. 
Use `alpha = .5` in `geom_boxplot()` and `geom_violin()` to layer both plots on top of one another. What does this tell you about the distribution of weight in "`bad`" guys?

```r
superhero_info %>% 
  filter(alignment != "NA") %>% 
  ggplot(aes(x = alignment, y = weight, fill = alignment))+
  geom_violin(alpha=0.5, na.rm = TRUE)+
  geom_boxplot(alpha=0.5, color = "grey", na.rm = TRUE)+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(x="alignment",
       y="weight")
```

![](lab14_hw_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

```r
# There are many bad guys' weight is close to mean value.
```

### 5. 
Box plots are great for showing how the distribution of a numeric variable (e.g. weight) varies among a categorical variable (e.g. alignment).
  Make your own violin plot with the superhero data. 
  What is your numeric data? Height
  What is your categorical variable? Gender

```r
superhero_info %>% 
  filter(gender !="NA") %>% 
  ggplot(aes(x=gender, y=height, fill=gender))+
  geom_boxplot(alpha=0.5, color="grey", na.rm = TRUE)+
  geom_violin(alpha=0.5, na.rm = TRUE)+
  theme_linedraw()+
  scale_fill_brewer(palette = "Pastel1")+
  labs(title = "Superhero Gender vs. Height",
       x="gender",
       y="height")+
    theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))+
  coord_flip()
```

![](lab14_hw_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

### 6. 
Remind yourself what `beachbugs` looks like. Then generate a heatmap of buglevels by site and year. 
color it with `scale_fill_gradient(low="yellow", high="red")` or colors of your choice. you may find it looks best with one color!
(dont forget, `coord_flip()` is a quick way to improve the look of your plot if you dont like the default orientation)


```r
head(beachbugs_long)
```

```
## # A tibble: 6 × 3
##    year site               buglevels
##   <dbl> <chr>                  <dbl>
## 1  2013 Bondi Beach            32.2 
## 2  2013 Bronte Beach           26.8 
## 3  2013 Clovelly Beach          9.28
## 4  2013 Coogee Beach           39.7 
## 5  2013 Gordons Bay (East)     24.8 
## 6  2013 Little Bay Beach      122.
```


```r
beachbugs_long %>% 
  ggplot(aes(x=site, y=year, fill=buglevels))+
  geom_tile()+
  scale_fill_gradient(low="yellow", high="red")+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(x = "Site",
       y = NULL)
```

![](lab14_hw_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

### 7.  
Use the provided code to normalize the beachbug data set. 
Then make a heatmap with the `beachbugs_normalized` data, and use the same color chois as above. Which heatmap do you think is more informative? why?


```r
#makes a new column of the highest buglevel observed at each site
beachbugs_w_max <- beachbugs_long %>% 
  group_by(site) %>% 
  mutate(max_buglevel = max(buglevels, na.rm=T)) %>% 
  arrange(site)
beachbugs_w_max
```

```
## # A tibble: 66 × 4
## # Groups:   site [11]
##     year site         buglevels max_buglevel
##    <dbl> <chr>            <dbl>        <dbl>
##  1  2013 Bondi Beach       32.2         32.2
##  2  2014 Bondi Beach       11.1         32.2
##  3  2015 Bondi Beach       14.3         32.2
##  4  2016 Bondi Beach       19.4         32.2
##  5  2017 Bondi Beach       13.2         32.2
##  6  2018 Bondi Beach       22.9         32.2
##  7  2013 Bronte Beach      26.8         61.3
##  8  2014 Bronte Beach      17.5         61.3
##  9  2015 Bronte Beach      23.6         61.3
## 10  2016 Bronte Beach      61.3         61.3
## # … with 56 more rows
```

```r
#makes a new table where the buglevels are normalized to the max_buglevel
beachbugs_normalized <- beachbugs_w_max %>% 
  group_by(site) %>% 
  mutate(norm_buglevel = buglevels/max_buglevel) %>% 
  arrange(site,year) %>%
  select(site, year, norm_buglevel)   # you dont have to select(), but I think its a clearer looking table
beachbugs_normalized
```

```
## # A tibble: 66 × 3
## # Groups:   site [11]
##    site          year norm_buglevel
##    <chr>        <dbl>         <dbl>
##  1 Bondi Beach   2013         1    
##  2 Bondi Beach   2014         0.344
##  3 Bondi Beach   2015         0.445
##  4 Bondi Beach   2016         0.601
##  5 Bondi Beach   2017         0.409
##  6 Bondi Beach   2018         0.710
##  7 Bronte Beach  2013         0.436
##  8 Bronte Beach  2014         0.285
##  9 Bronte Beach  2015         0.385
## 10 Bronte Beach  2016         1    
## # … with 56 more rows
```
 

```r
beachbugs_normalized %>% 
  ggplot(aes(x=site, y=year, fill=norm_buglevel))+
  geom_tile()+
  scale_fill_gradient(low="yellow", high="red")+
  theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  labs(x = "Site",
       y = NULL)
```

![](lab14_hw_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

```r
# I think this is better because there are more color differences in this heatmap.
```

### 8.
Let's make a venn diagram of `superhero_info`, from 4 questions:
Is their alignment evil? 
Are their eyes red?
Are they male?
Are they bald?

Start by making the 4 vectors, then the list of vectors. The vector for alignment is provided:
### super heros venn

```r
# evil
evil_vec <- superhero_info %>%
  filter(alignment == "bad")%>%
  pull(name)

# red eyes
red_eye_vec <- superhero_info %>% 
  filter(eye_color == "red") %>% 
  pull(name)

# male
male_vec <- superhero_info %>% 
  filter(gender == "Male") %>% 
  pull(name)

# bald
bald_vec <- superhero_info %>% 
  filter(hair_color == "No Hair") %>% 
  pull(name)
```

Your list of vectors will look something like this:

```r
evil_redeye_male_bald_list <- list(evil_vec, red_eye_vec, male_vec, bald_vec)
```

### 9. 
Let's make the venn diagram! use the code from lab as a reference. 

```r
# something like:
# ggVennDiagram( list, category.names = c("name", "name", "name", "name"))

ggVennDiagram(evil_redeye_male_bald_list, category.names = c("Evil", "Red Eye", "Male", "Bald"))
```

![](lab14_hw_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


### 10. Choose one intersection of the venn diagram that is interesting to you. Use dplyr to find the names of the superheros in that intersection. 


```r
superhero_info %>% 
  filter(gender == "Male" & hair_color != "No Hair" & eye_color !="red" & alignment !="bad") %>% 
  pull(name)
```

```
##   [1] "Adam Monroe"       "Adam Strange"      "Agent Bob"        
##   [4] "Alan Scott"        "Alfred Pennyworth" "Angel"            
##   [7] "Animal Man"        "Ant-Man"           "Ant-Man II"       
##  [10] "Aquababy"          "Aqualad"           "Aquaman"          
##  [13] "Archangel"         "Ares"              "Astro Boy"        
##  [16] "Atlas"             "Atom"              "Atom II"          
##  [19] "Atom IV"           "Azrael"            "Banshee"          
##  [22] "Bantam"            "Batman"            "Batman"           
##  [25] "Batman II"         "Battlestar"        "Beak"             
##  [28] "Beast"             "Beast Boy"         "Bizarro"          
##  [31] "Black Bolt"        "Black Knight III"  "Black Panther"    
##  [34] "Blade"             "Blue Beetle"       "Blue Beetle II"   
##  [37] "Blue Beetle III"   "Booster Gold"      "Brainiac 5"       
##  [40] "Brother Voodoo"    "Cable"             "Cannonball"       
##  [43] "Captain America"   "Captain Atom"      "Captain Britain"  
##  [46] "Captain Cold"      "Captain Epic"      "Captain Mar-vell" 
##  [49] "Captain Marvel"    "Captain Marvel II" "Century"          
##  [52] "Chamber"           "Citizen Steel"     "Cloak"            
##  [55] "Colin Wagner"      "Colossus"          "Corsair"          
##  [58] "Crimson Crusader"  "Cyborg"            "Cyclops"          
##  [61] "Danny Cooper"      "Daredevil"         "Darkhawk"         
##  [64] "Dash"              "Data"              "Deadman"          
##  [67] "Deathlok"          "Deathstroke"       "Doc Samson"       
##  [70] "Doctor Fate"       "Doctor Strange"    "Elongated Man"    
##  [73] "Ethan Hunt"        "Falcon"            "Firestorm"        
##  [76] "Firestorm"         "Flash"             "Flash II"         
##  [79] "Flash IV"          "Franklin Richards" "Galactus"         
##  [82] "Genesis"           "Gladiator"         "Goliath IV"       
##  [85] "Gravity"           "Green Arrow"       "Green Goblin IV"  
##  [88] "Guardian"          "Guy Gardner"       "Hal Jordan"       
##  [91] "Han Solo"          "Hancock"           "Harry Potter"     
##  [94] "Havok"             "Hawkeye"           "Hawkman"          
##  [97] "Hellboy"           "Hercules"          "Howard the Duck"  
## [100] "Hulk"              "Human Torch"       "Hybrid"           
## [103] "Hyperion"          "Iceman"            "Impulse"          
## [106] "Iron Fist"         "Iron Man"          "Jack of Hearts"   
## [109] "Jack-Jack"         "James Bond"        "James T. Kirk"    
## [112] "John Constantine"  "John Stewart"      "John Wraith"      
## [115] "Juggernaut"        "Justice"           "Karate Kid"       
## [118] "Kick-Ass"          "Kid Flash"         "King Kong"        
## [121] "Krypto"            "Kyle Rayner"       "Legion"           
## [124] "Lightning Lad"     "Longshot"          "Luke Cage"        
## [127] "Luke Skywalker"    "Magog"             "Man-Bat"          
## [130] "Man-Wolf"          "Master Brood"      "Master Chief"     
## [133] "Maverick"          "Metron"            "Micah Sanders"    
## [136] "Micro Lad"         "Mimic"             "Mister Fantastic" 
## [139] "Monarch"           "Moon Knight"       "Mr Immortal"      
## [142] "Mr Incredible"     "Multiple Man"      "Namor"            
## [145] "Nick Fury"         "Nightcrawler"      "Nightwing"        
## [148] "Northstar"         "Nova"              "Odin"             
## [151] "Omniscient"        "Osiris"            "Penance II"       
## [154] "Plastic Man"       "Punisher"          "Question"         
## [157] "Quicksilver"       "Quill"             "Rambo"            
## [160] "Ray"               "Red Arrow"         "Red Hood"         
## [163] "Red Hulk"          "Red Robin"         "Rip Hunter"       
## [166] "Robin"             "Robin II"          "Robin III"        
## [169] "Robin V"           "Rocket Raccoon"    "Ronin"            
## [172] "Rorschach"         "Sandman"           "Scarlet Spider"   
## [175] "Scarlet Spider II" "Sentry"            "Shang-Chi"        
## [178] "Shatterstar"       "Simon Baz"         "Sinestro"         
## [181] "Skaar"             "Spawn"             "Spider-Man"       
## [184] "Spider-Man"        "Spock"             "Spyke"            
## [187] "Star-Lord"         "Static"            "Sunspot"          
## [190] "Superboy"          "Superman"          "Synch"            
## [193] "The Comedian"      "Thor"              "Thunderbird"      
## [196] "Thunderbird III"   "Thunderstrike"     "Toad"             
## [199] "Toxin"             "Toxin"             "Vibe"             
## [202] "Vulcan"            "War Machine"       "Warpath"          
## [205] "Winter Soldier"    "Wolverine"         "Wyatt Wingfoot"   
## [208] "X-Man"             "Yellowjacket"      "Yoda"
```



### 11. Make another venn diagram with the `superhero_info` data. What are your questions? ( At least 2!) 
Is their alignment good? 
Are their eyes blue?
Are they from Marvel Comics?

```r
# good
good_vec <- superhero_info %>%
  filter(alignment == "good")%>%
  pull(name)

# blue eyes
blue_eye_vec <- superhero_info %>% 
  filter(eye_color == "blue") %>% 
  pull(name)

# Marvel
marvel_vec <- superhero_info %>% 
  filter(publisher == "Marvel Comics") %>% 
  pull(name)
```


```r
good_blueeye_marvel_list <- list(good_vec, blue_eye_vec, marvel_vec)

ggVennDiagram(good_blueeye_marvel_list, category.names = c("Good", "Blue Eye", "Marvel"))
```

![](lab14_hw_files/figure-html/unnamed-chunk-19-1.png)<!-- -->


### 12.
What are some very common super powers? Lets make a word cloud with the `superhero_powers` data.

Use the provided code to make the frequency table, then make a word cloud with it. 
Remember, you can change `scale_size_area(max_size = 20)` to a different number if the words wont fit!


```r
head(superhero_powers)
```

```
## # A tibble: 6 × 168
##   hero_names  Agility `Accelerated Healing` `Lantern Power Ri…` `Dimensional A…`
##   <chr>       <lgl>   <lgl>                 <lgl>               <lgl>           
## 1 3-D Man     TRUE    FALSE                 FALSE               FALSE           
## 2 A-Bomb      FALSE   TRUE                  FALSE               FALSE           
## 3 Abe Sapien  TRUE    TRUE                  FALSE               FALSE           
## 4 Abin Sur    FALSE   FALSE                 TRUE                FALSE           
## 5 Abomination FALSE   TRUE                  FALSE               FALSE           
## 6 Abraxas     FALSE   FALSE                 FALSE               TRUE            
## # … with 163 more variables: `Cold Resistance` <lgl>, Durability <lgl>,
## #   Stealth <lgl>, `Energy Absorption` <lgl>, Flight <lgl>,
## #   `Danger Sense` <lgl>, `Underwater breathing` <lgl>, Marksmanship <lgl>,
## #   `Weapons Master` <lgl>, `Power Augmentation` <lgl>,
## #   `Animal Attributes` <lgl>, Longevity <lgl>, Intelligence <lgl>,
## #   `Super Strength` <lgl>, Cryokinesis <lgl>, Telepathy <lgl>,
## #   `Energy Armor` <lgl>, `Energy Blasts` <lgl>, Duplication <lgl>, …
```

```r
power_frequency <- superhero_powers %>% 
  select(-hero_names) %>%
  summarise_all(~(sum(.))) %>%
  pivot_longer(everything(), names_to = "power", values_to = "freq")
power_frequency
```

```
## # A tibble: 167 × 2
##    power                  freq
##    <chr>                 <int>
##  1 Agility                 242
##  2 Accelerated Healing     178
##  3 Lantern Power Ring       11
##  4 Dimensional Awareness    25
##  5 Cold Resistance          47
##  6 Durability              257
##  7 Stealth                 126
##  8 Energy Absorption        77
##  9 Flight                  212
## 10 Danger Sense             30
## # … with 157 more rows
```



```r
power_frequency %>% 
ggplot(aes(
  label = power, 
  size = freq,
  color = power
  )) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 8) +
  theme_minimal()
```

![](lab14_hw_files/figure-html/unnamed-chunk-22-1.png)<!-- -->
### 13.  
Who are some very powerful supers? 
 Lets make a different word cloud with the `superhero_powers` data. 
Use the provided code to make the frequency table, then make a word cloud with it.
You can use `hero_names` for the labels, and `sum_powers` for size. 


```r
power_quantity <- superhero_powers %>% 
  pivot_longer(-hero_names, names_to = "power", values_to = "yes_or_no") %>% 
  group_by(hero_names) %>% 
  mutate(sum_powers = sum(yes_or_no, na.rm=T)) %>%
  arrange(desc(sum_powers), hero_names, desc(yes_or_no))
power_quantity
```

```
## # A tibble: 111,389 × 4
## # Groups:   hero_names [667]
##    hero_names power                 yes_or_no sum_powers
##    <chr>      <chr>                 <lgl>          <int>
##  1 Spectre    Agility               TRUE              49
##  2 Spectre    Accelerated Healing   TRUE              49
##  3 Spectre    Dimensional Awareness TRUE              49
##  4 Spectre    Stealth               TRUE              49
##  5 Spectre    Energy Absorption     TRUE              49
##  6 Spectre    Flight                TRUE              49
##  7 Spectre    Marksmanship          TRUE              49
##  8 Spectre    Longevity             TRUE              49
##  9 Spectre    Intelligence          TRUE              49
## 10 Spectre    Super Strength        TRUE              49
## # … with 111,379 more rows
```

```r
#we have to trim down to only the top 50, or it will crowd the image!
power_quantity <- power_quantity %>% 
  ungroup %>%
  distinct(hero_names, sum_powers) %>%
  slice_max(sum_powers, n = 50)
power_quantity
```

```
## # A tibble: 51 × 2
##    hero_names        sum_powers
##    <chr>                  <int>
##  1 Spectre                   49
##  2 Amazo                     44
##  3 Living Tribunal           35
##  4 Martian Manhunter         35
##  5 Man of Miracles           34
##  6 Captain Marvel            33
##  7 T-X                       33
##  8 Galactus                  32
##  9 T-1000                    32
## 10 Mister Mxyzptlk           31
## # … with 41 more rows
```




```r
power_quantity %>% 
ggplot(aes(
  label = hero_names, 
  size = sum_powers,
  color = hero_names
  )) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 8) +
  theme_minimal()
```

```
## Warning in wordcloud_boxes(data_points = points_valid_first, boxes = boxes, :
## Some words could not fit on page. They have been placed at their original
## positions.
```

![](lab14_hw_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

## That's it! 🎉
Thanks for coding with us all winter! 
Now go finish your group project :) 

