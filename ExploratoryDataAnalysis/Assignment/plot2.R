# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(dplyr)

sourceData <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

zipFile <- 'NEI_data.zip'

NEIFile <- 'summarySCC_PM25.rds'

if (!file.exists(zipFile)) {
  download.file(sourceData, zipFile)
}

if (!file.exists(NEIFile)) {
  unzip(zipFile)
}

if (!file.exists(NEIFile)) {
  stop(paste0("Could not get",NEIFile) )
}

if (!exists("NEI")) {
  NEI <- readRDS(NEIFile)
}

pBalt <- filter(NEI, fips == "24510")

pSumm <- group_by(pBalt, year)
pSummTotal <- summarize(pSumm, total = sum(Emissions))
#pSummTotal
# A tibble: 4 x 2
#year   total
#<int>   <dbl>
#1  1999 7332967
#2  2002 5635780
#3  2005 5454703
#4  2008 3464206

png(file="plot2.png",width=480,height=480)

with(pSummTotal, plot(year, total, xlab="Year", ylab = "Total pm 2.5 tons",
                      main = "Total Baltimore pm 2.5 tons by year"))

dev.off()