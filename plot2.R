#Read data from file
data.hpc <- read.table("household_power_consumption.txt",header=TRUE, 
                                  sep=";",na.strings = c("?",""))
#I studied a several tricks haw to read not all but part of data from this reference
#http://stackoverflow.com/questions/23197243/how-do-i-read-only-lines-that-fulfil-a-condition-from-a-csv-into-r
#I played with some tricks but for common use i prefer to read whole file :)
#I don't know your OS, installed packages and other important things


#Convert Data and Time columns in special R format
data.hpc$Date<-as.Date(data.hpc$Date, format = "%d/%m/%Y")
data.hpc$Time <- strptime(paste(data.hpc$Date, data.hpc$Time), format = "%Y-%m-%d %H:%M:%S")  

#According assignment we need only data from dates 2007-02-01 and 2007-02-02 
data.hpc<-subset(data.hpc, data.hpc$Date==as.Date("2007-02-01") | data.hpc$Date==as.Date("2007-02-02"))

#Use png device to create resulting file 
png(filename = "plot2.png", width = 480, height = 480)

#I am not English man (to see week days in English)
Sys.setlocale(locale="English")

# Draw picture
plot(data.hpc$Time,data.hpc$Global_active_power,type="l",
     main="",xlab="", ylab="Global Active Power (kilowatts)")

dev.off()