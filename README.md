# BowmanFieldWeatherAnalysis

Data can be obtained from: 

https://www7.ncdc.noaa.gov/CDO/cdopoemain.cmd?datasetabbv=DS3505&countryabbv=&georegionabbv=&resolution=40 

Use the "Continue With SIMPLIFIED Options" button. Select United States, select Kentucky, select Bowman Field Airport, select timeframe.

# Sample Data (Links expire on 2/2/2018)

Temporary data from 2017-12-01 to 2017-12-31: https://www.ncdc.noaa.gov/orders/isd/CDO1970727539654.html

Temporary data from 1988-01-01 to 2017-12-31: https://www.ncdc.noaa.gov/orders/isd/CDO6980487539681.html (order pending as of 1/25/2018 @ 11:07AM local)

# Importing data to R

```
file <- "http://www.ncdc.noaa.gov/orders/isd/1970727539654dat.txt"
  ## Note: file should be saved to hard drive because web address is temporary.
readLines(file,n=2)
df <- read.delim(file,header=TRUE, sep = "", as.is = TRUE, fill = TRUE)
```
