## function that calculates the number of lines in the text file between to dates/times 
## d1 and d2 are strings, same format as "Date" and "Time" of the text file

## Text file should be in the same directory

n_lignes <- function(d2, d1 = "16/12/2006 17:24:00") {
  t1 <-  strptime(d1, "%d/%m/%Y %H:%M:%S")
  t2 <-  strptime(d2, "%d/%m/%Y %H:%M:%S")
  l <- difftime(t2,t1, units = "mins") + 1
  l
}


## Extract  l2 rows in the text file, beginning at l1 row
## Add Header

extract_file <- function(l1,l2) {
  dataset  <- read.table(file = "household_power_consumption.txt", sep = ";", header = FALSE, as.is = TRUE, skip = l1, nrows = l2, na.strings = "?")
  head <- read.table(file = "household_power_consumption.txt", sep = ";", header = FALSE, as.is = TRUE, nrows = 1)
  names(dataset) <- head
  Date_time  <- paste(dataset$Date,dataset$Time, sep = " ")
  Date_time  <- strptime(Date_time, "%d/%m/%Y %H:%M:%S")
  dataset  <- data.frame(Date_time, dataset)
  dataset
}

## Create plot1 with extracted data between date/time d1 and date/time d2
## Date/Time in format character "d/m/Y H:M:S"
## Read data from file

  l1  <- n_lignes("1/2/2007 00:00:00")
  l2  <- n_lignes("2/2/2007 23:59:00","1/2/2007 00:00:00")
  data.hpc <- extract_file(l1,l2)

## Use png device to create resulting file 
  
png(filename = "plot1.png",
    width = 480, height = 480)

# Draw histogram

hist(data.hpc$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

dev.off()