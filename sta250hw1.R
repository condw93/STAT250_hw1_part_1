## Computing the results from the data

library(SDMTools) # Will use this to construct weighted mean, standard deviation and median

setwd("~/250_Data") # Be in the directory with the data

## Begin analyzing the data and timing

begTime = Sys.time() # Will begin timing computations

Delay1987_1989 = as.integer(readLines('ArrDelay_1987_1989.csv'))
Delay1990_1999 = as.integer(readLines('ArrDelay_1990_1999.csv'))
Delay2000_2004 = as.integer(readLines('ArrDelay_2000_2004.csv'))
Delay2005_2007 = as.integer(readLines('ArrDelay_2005_2007.csv'))
Delay2008_2012 = as.integer(readLines('ArrDelay_2008_2012.csv')) # Read in the delay values, turn them into integers; keep them as blocks so as to avoid numerical overflow

mu = wt.mean(c(mean(Delay1987_1989, na.rm = TRUE), mean(Delay1990_1999, na.rm = TRUE), mean(Delay2000_2004, na.rm = TRUE), mean(Delay2005_2007, na.rm = TRUE), mean(Delay2008_2012, na.rm = TRUE)), c(length(Delay1987_1989), length(Delay1990_1999), length(Delay2000_2004), length(Delay2005_2007), length(Delay2008_2012))) # Use the weighted mean function; to reduce computing time, average the means of each file with the weights corresponding to how many observations are in each file, instead of inputting all of the values and then averaging them (take the weighted mean of means to  approximate a good estimate of the population mean)

std = wt.mean(c(sd(Delay1987_1989, na.rm = TRUE), sd(Delay1990_1999, na.rm = TRUE), sd(Delay2000_2004, na.rm = TRUE), sd(Delay2005_2007, na.rm = TRUE), sd(Delay2008_2012, na.rm = TRUE)), c(length(Delay1987_1989),length(Delay1990_1999),length(Delay2000_2004),length(Delay2005_2007),length(Delay2008_2012))) # Do the same thing, but average the standard deviations of each file, and have the same weights (this should give an okay approximation of the standard deviation)

med = wt.mean(c(median(Delay1987_1989, na.rm = TRUE), median(Delay1990_1999, na.rm = TRUE), median(Delay2000_2004, na.rm = TRUE), median(Delay2005_2007, na.rm = TRUE), median(Delay2008_2012, na.rm = TRUE)), c(length(Delay1987_1989), length(Delay1990_1999), length(Delay2000_2004), length(Delay2005_2007), length(Delay2008_2012))) # Do the same thing, but this time average the medians of each file, using the same weights (I actually have no idea how good of an approximation of the median this will be, but this is all I could think of doing)

runTime = Sys.time() - begTime # Will find how long to took to run the computations

resultSummary = list(time = runTime, results = c(mean = mu, median = med, sd = std), system = Sys.info(), session = sessionInfo(), processor = 'Intel Core i7-2670QM CPU @ 2.20GHz (Mobile Quadcore)', memory = '12.0 GB DDR3 RAM')

save(resultSummary, file = "results1.rda")
