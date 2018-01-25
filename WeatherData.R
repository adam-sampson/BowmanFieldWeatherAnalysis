
#   ============================================================================
#                       Term 4 - Time Series Group Project            
#   ============================================================================
#   Purpose: Bowman Field Weather Analysis 
#   ============================================================================
#   Created: 01/25/2018
#   Members: Jay Bektasevic, Andrew Brill, Adam Sampson, Brenden McGale, 
#            Taylor Maxon 
#            Bellarmine University
#   ----------------------------------------------------------------------------


#   ____________________________________________________________________________
#   Load Required Packages and Files  


#   Check that necessary packages are installed
    packages <- c("tidyverse", "lubridate")
    new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
    if(length(new_packages)) install.packages(new_packages)

#   Load Neccessary Packages
    sapply(packages, require, character.only = TRUE)

#   Note: file should be saved to hard drive because web address is temporary.
    file <- "BowmanField_1988-2017_dat.txt"
#   readLines(file,n=2) ## If you just want to see a couple lines instead of loading all.
    df <- read.delim(file,header=TRUE, sep = "", as.is = TRUE, fill = TRUE)
    
#   Fix the date column name and formating
    colnames(df)[3] <- "DATE_TIME"
    df$DATE_TIME <- ymd_hm(df[,3])
        
#   Save df dataset 
    save(df, file = "df.Rdata")    
    