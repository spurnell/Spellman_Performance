library(shiny)
library(shinydashboard)
library(tidyverse)
library(rsconnect)
library(DT)
library(formattable)
library(scales)
library(plotly)
library(ggplot2)
library(data.table)
library(magrittr)
library(flextable)
library(googlesheets4)





df <-  read_csv(file = "FVP_Feeder.csv", col_names = TRUE)

df <- df %>% 
  rename("Maximal Force Output" = "F0 norm",
         "Maximal Velocity Output" = "V0",
         "Max Power Output" = "Pmax norm",
         "Decrease in Horizontal Force" = "DRF",
         "Maximal Horizontal Force at Start" = "RFMax")



df_c <- read_csv(file = "FVP_Feeder.csv", col_names = TRUE)

df_c[1,1] <-"Performance Standard"

df_c <- df_c %>% 
  rename("Maximal Force Output" = "F0 norm",
         "Maximal Velocity Output" = "V0",
         "Max Power Output" = "Pmax norm",
         "Decrease in Horizontal Force" = "DRF",
         "Maximal Horizontal Force at Start" = "RFMax")

df_p <- df_c %>% 
  dplyr::mutate("Percentage of Maximal Force Ouput" = formattable::percent(`Maximal Force Output`/ max(`Maximal Force Output`))) %>% 
  dplyr::mutate("Percentage of Maximal Velocity Ouput" = formattable::percent(`Maximal Velocity Output`/ max(`Maximal Velocity Output`))) %>% 
  dplyr::mutate("Percentage of Max Power Ouput" = formattable::percent(`Max Power Output`/ max(`Max Power Output`))) %>% 
  dplyr::mutate("Percentage of Decrease in Horizontal Force" = formattable::percent(`Decrease in Horizontal Force`/ max(`Decrease in Horizontal Force`))) %>% 
  dplyr::mutate("Percentage of Maximal Horizontal Force at Start" = formattable::percent(`Maximal Horizontal Force at Start`/ max(`Maximal Horizontal Force at Start`))) 
  
  

names <-  df %>% select("Full Name")


#NEed to creates standrd.z to make set variable 

