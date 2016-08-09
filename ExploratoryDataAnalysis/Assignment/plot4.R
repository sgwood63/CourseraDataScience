# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

# get the SCC coding for Coal and Combustion

coalSCC <- filter(SCC, grepl("Coal", EI.Sector) & grepl("Combustion", SCC.Level.One))

# merge with full Emissions data set to get Coal Combustion readings for the US

pCoded <- merge(NEI, coalSCC)

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

png(file="plot4.png",width=480,height=480)

# ggplot it

print(ggplot(data=pSummTotal, aes(x=year, y=total)) +
  geom_line() +
  geom_point() +
  xlab("Year") + ylab("Total pm 2.5 tons") + ggtitle("Total US pm 2.5 tons from Coal Combustion by year"))

dev.off()
