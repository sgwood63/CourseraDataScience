# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

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

# Get emissions readings for Baltimore and Los Angeles

pBaltLA <- filter(NEI, fips == "24510" | fips == "06037")

# get the SCC coding for motor vehicles

OnroadSCC <- filter(SCC, grepl("Onroad", Data.Category))

# merge with Baltimore and LA data set to get motor vehicle readings
pCoded <- merge(pBaltLA, OnroadSCC)

# summarize by year

pSumm <- group_by(pCoded, year, fips)
pSummTotal <- summarize(pSumm, total = sum(Emissions))
#pSummTotal
## A tibble: 4 x 2
#year    total
#<int>    <dbl>
#  1  1999 572126.5
#2  2002 546789.2
#3  2005 552881.5
#4  2008 343432.2

png(file="plot6.png",width=480,height=480)

# ggplot it
# legend(legend = c('Baltimore', 'Los Angeles'), title = 'City')

print(
  ggplot(data=pSummTotal, aes(x=year, y=total, group=fips, colour=fips)) +
  geom_line() +
  geom_point() +
  scale_color_discrete(name ="City", labels=c('Los Angeles', 'Baltimore')) +
  xlab("Year") + ylab("Total pm 2.5 tons") + ggtitle("Total Baltimore vs LA pm 2.5 tons from motor vehicles by year") 
  )

dev.off()

