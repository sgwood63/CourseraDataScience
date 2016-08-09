# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

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

# focus on Balimore
pBalt <- filter(NEI, fips == "24510")

# get the coding for each SCC
pBaltCoded <- merge(pBalt, SCC)

# summarize by year and type

pSumm <- group_by(pBaltCoded, year, type)
pSummTotal <- summarize(pSumm, total = sum(Emissions))
#pSummTotal
#Source: local data frame [16 x 3]
#Groups: year [?]
#
#year     type      total
#<int>    <chr>      <dbl>
#  1   1999 NON-ROAD  522.94000
#2   1999 NONPOINT 2107.62500
#3   1999  ON-ROAD  346.82000
#4   1999    POINT  296.79500
#5   2002 NON-ROAD  240.84692
#6   2002 NONPOINT 1509.50000
#7   2002  ON-ROAD  134.30882
#8   2002    POINT  569.26000
#9   2005 NON-ROAD  248.93369
#10  2005 NONPOINT 1509.50000
#11  2005  ON-ROAD  130.43038
#12  2005    POINT 1202.49000
#13  2008 NON-ROAD   55.82356
#14  2008 NONPOINT 1373.20731
#15  2008  ON-ROAD   88.27546
#16  2008    POINT  344.97518

png(file="plot3.png",width=480,height=480)

# ggplot it

print(ggplot(data=pSummTotal, aes(x=year, y=total, group=type, colour=type)) +
  geom_line() +
  geom_point() +
  xlab("Year") + ylab("Total pm 2.5 tons") + ggtitle("Total Baltimore pm 2.5 tons by year"))

dev.off()
