## NSC GR DA for Deans ##
## 14 Oct 2025 ##

####### Setup ####### 
cat(rep("\n", 50))
rm(list=ls())
gc(reset = TRUE)
options(scipen=99)
setwd("/Users/ananni/Desktop")

####### Packages #######
library(readxl)
library(magrittr)
library(tidyverse)
library(lubridate)

###### Load and Format ######

list <- read_excel("GR All Lost Admits List - Fall 20205 Term - 20251008 (131).xlsx")

list$BIRTH_DATE <- ymd(list$Birthdate)

list$BIRTHDATE <- format(list$BIRTH_DATE, "%Y%m%d")

list$MI <-  list$Middle

list$MI[is.na(list$MI)] <- ""

list <- list %>% select(First, MI, Last, BIRTHDATE, `RWU ID`)

###### Save as .csv ######

write_csv(list, "list.csv")