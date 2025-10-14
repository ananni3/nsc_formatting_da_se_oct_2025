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

list <- read_excel("SE_UG_grads_2023_to_pres.xlsx")
bd <- read_excel("birthdates.xlsx")

list <- list %>% select(`Birth/ChosenFirstName`,
                        SortName,
                        LastName,
                        ID)

list$First <- list$`Birth/ChosenFirstName`
list$Last <-  list$LastName

list <- list %>% left_join(bd, by = "ID")

list$Birthdate <- mdy(list$Birthdate)

list$BIRTHDATE <- format(list$Birthdate, "%Y%m%d")

list <- dplyr::mutate(list, MI = dplyr::if_else(stringr::str_detect(stringr::str_trim(SortName), "\\.$"), stringr::str_sub(stringr::str_trim(SortName), -2, -2), ""))

list <- list %>% select(First, MI, Last, BIRTHDATE, ID)

###### Save as .csv ######

write_csv(list, "se_list.csv")