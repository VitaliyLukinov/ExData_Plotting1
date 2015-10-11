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
png(filename = "plot3.png", width = 480, height = 480)

#I am not English man (to see week days in English)
Sys.setlocale(locale="English")

# Draw picture
with(data.hpc, plot(Time,Sub_metering_1,type="l",
     main="",xlab="", ylab="Energy sub metering"))
with(data.hpc, points(Time,Sub_metering_2,type="l", col="red"))
with(data.hpc, points(Time,Sub_metering_3,type="l", col="blue"))
legend("topright", lty=1,
       col    = c("black",          "red",            "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()