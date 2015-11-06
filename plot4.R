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

#Use png device to create resulting file 
png(filename = "plot4.png", width = 480, height = 480)

#I am not English man (to see week days in English)
Sys.setlocale(locale="English")

# Draw picture
par(mfrow = c(2, 2))
with(data.hpc, {
    plot(Date_time, Global_active_power,type="l",
         main="",xlab="", ylab="Global Active Power")
    plot(Date_time, Voltage,type="l",
         main="",xlab="datetime", ylab="Voltage")
    plot(Date_time,Sub_metering_1,type="l",
         main="",xlab="", ylab="Energy sub metering")
    points(Date_time,Sub_metering_2,type="l", col="red")
    points(Date_time,Sub_metering_3,type="l", col="blue")
    legend("topright", lty=1, bty="n",
       col    = c("black",          "red",            "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Date_time, Global_reactive_power,type="l",
         main="",xlab="datetime")
})
dev.off()