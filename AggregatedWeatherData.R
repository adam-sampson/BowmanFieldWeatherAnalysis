##########
## Aggregate weather data for easier viewing / analysis
##########

#---
# Load Packages
#---
  packages <- c("tidyverse", "lubridate", "xts", "stringr","forecast")
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) install.packages(new_packages)
  #   Load Neccessary Packages
  sapply(packages, require, character.only = TRUE)
  rm(new_packages)
  
#---
# Aggregate data daily
#---
  meanDaily <- function(single.ts) {
    out <- apply.daily(single.ts,mean,na.rm=TRUE)
    return(out)
  }
  
  aggrDaily <- function(single.ts) {
    out <- apply.daily(single.ts,min,na.rm=TRUE)
    out <- cbind(out,apply.daily(single.ts,mean,na.rm=TRUE))
    out <- cbind(out,apply.daily(single.ts,max,na.rm=TRUE))
    names(out) <- c("Min","Mean","Max")
    return(out)
  }
  
  # daily.temp <- aggrDaily(clean.df.ts$TEMP)
  # dygraph(daily.temp)
  