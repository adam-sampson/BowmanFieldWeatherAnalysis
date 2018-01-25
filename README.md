# BowmanFieldWeatherAnalysis

Data can be obtained from: 

https://www7.ncdc.noaa.gov/CDO/cdopoemain.cmd?datasetabbv=DS3505&countryabbv=&georegionabbv=&resolution=40 

Use the "Continue With SIMPLIFIED Options" button. Select United States, select Kentucky, select Bowman Field Airport, select timeframe.

# Sample Data (Links expire on 2/2/2018)

Temporary data from 2017-12-01 to 2017-12-31: https://www.ncdc.noaa.gov/orders/isd/CDO1970727539654.html

Temporary data from 1988-01-01 to 2017-12-31: https://www.ncdc.noaa.gov/orders/isd/CDO6980487539681.html 

# Importing data to R

```
## Note: file should be saved to hard drive because web address is temporary.
file1 <- "http://www.ncdc.noaa.gov/orders/isd/1970727539654dat.txt"
file2 <- "https://www.ncdc.noaa.gov/orders/isd/6980487539681dat.txt"
## readLines(file,n=2) ## If you just want to see a couple lines instead of loading all.
df1 <- read.delim(file1,header=TRUE, sep = "", as.is = TRUE, fill = TRUE)
df2 <- read.delim(file2,header=TRUE, sep = "", as.is = TRUE, fill = TRUE)
```
