
# Finding and Eliminating missing values in Time series data ----------------------------------

# In time series data, there should not be any missing values in series.Some times there is possibility
# of having such missing values in between series.It will cause more harmfull if we are not aware of them.
#We are here now to see the impact of missing values on time series data.

#Let me create a time series data on user access to a website. This log file 
#just contains the date of access, and how many accesses were counted
hdata <- data.frame(
  date = seq(as.Date('1988-04-20'),by ='days' , length = 100),
  hits = round(sample(rnorm(100, mean = 110, sd =11),100))
)
### Deleted 5 observations randomly:
hdata <- hdata[sample(1:100,95,replace = F),]
hdata <- hdata[order(hdata$date),]
hdata$date <- as.Date(hdata$date,format="%m/%d/%Y")	# Timestamp is in mm/dd/YYYY format
### We succesfull got a data, having 5missing values in a series 
### Lets see how this plot looks like.
plot(hdata$hits,xaxt="no",type="l",main="Daily number of Interactions",ylab = "Number of Interactions",xlab="")

### Find those missing values and impute zeros in missiing vales and see how it effects plot
### generate vector of all dates
daycount <- table(hdata$date)  
alldays <- seq(as.Date('1988-04-20'),length=100,by="+1 day")			# this vector has all days
allcount <- table(alldays)      
actindex <- match(names(allcount),names(daycount),nomatch = 0)  
### Now we can see here there are 5 missing values:

### Lets mention the missing dates and provide hits as zero [0] for missing dates
library(dplyr)
alldays <- data.frame(date = alldays)
new_hdata <-  left_join(alldays, hdata)
new_hdata$hits[new_hdata$hits %in% NA] <- 0
#We have successfull done our job. lets plot it..
plot(new_hdata$hits,xaxt="no",type="l",main="Daily number of Interactions",ylab = "Number of Interactions",xlab="")

