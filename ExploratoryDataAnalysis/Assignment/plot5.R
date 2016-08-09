# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(ggplot2)

sourceData <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

zipFile <- 'NEI_data.zip'

NEIFile <- 'summarySCC_PM25.rds'
SCCFile <- 'Source_Classification_Code.rds'

if (!file.exists(zipFile)) {
  download.file(sourceData, zipFile)
}

if (!file.exists(NEIFile)) {
  unzip(zipFile)
}

if (!file.exists(NEIFile)) {
  stop(paste0("Could not get",NEIFile) )
}

if (!file.exists(SCCFile)) {
  stop(paste0("Could not get",SCCFile) )
}

if (!exists("NEI")) {
  NEI <- readRDS(NEIFile)
}

if (!exists("SCC")) {
  SCC <- readRDS(SCCFile)
}

# Get emissions readings for Baltimore

pBalt <- filter(NEI, fips == "24510")

# get the SCC coding for motor vehicles

OnroadSCC <- filter(SCC, grepl("Onroad", Data.Category))

# merge with Baltimore data set to get motor vehicle readings
pCoded <- merge(pBalt, OnroadSCC)

# summarize by year

pSumm <- group_by(pCoded, year)
pSummTotal <- summarize(pSumm, total = sum(Emissions))
#pSummTotal
## A tibble: 4 x 2
#year    total
#<int>    <dbl>
#  1  1999 572126.5
#2  2002 546789.2
#3  2005 552881.5
#4  2008 343432.2

png(file="plot5.png",width=480,height=480)

# ggplot it

print(ggplot(data=pSummTotal, aes(x=year, y=total)) +
  geom_line() +
  geom_point() +
  xlab("Year") + ylab("Total pm 2.5 tons") + ggtitle("Total Baltimore pm 2.5 tons from motor vehicles by year"))

dev.off()
