##########
## Cleanup weather data
##########

#---
# Load Packages
#---
  packages <- c("tidyverse", "lubridate", "xts", "stringr")
  new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
  if(length(new_packages)) install.packages(new_packages)
  #   Load Neccessary Packages
  sapply(packages, require, character.only = TRUE)
  rm(new_packages)
    
#---
# Replace missing values
#---
  clean.df <- df
  
  clean.df[clean.df[,"CLG"]=="722","CLG"] <- Inf
  
  for(col in names(clean.df)) {
    clean.df[,col] <- str_replace_all(clean.df[,col],"^[*]+$","NA")
    clean.df[clean.df[,col]=="NA",col] <- NA
  }
  
#---
# Generate stats about variables
#---
  clean.df.stats <- list()
  
  ## Determine what percent of a variable is NA
  clean.df.stats[["na_percent"]] <- list()
  for(col in names(clean.df)) {
    clean.df.stats[["na_percent"]][col] <- 100*sum(is.na(clean.df[,col]))/length(clean.df[,col])
  }
  clean.df.stats$na_percent
  
#---
# Fix variable types
#---
  clean.df$DATE_TIME <- ymd_hms(clean.df$DATE_TIME)
  
  numeric.var <- c("DIR","SPD","GUS","CLG","VSB","TEMP","DEWP","ALT")
  for(col in numeric.var) {
    clean.df[col] <- as.numeric(unlist(clean.df[col]))
  }
  rm(numeric.var)
  