library(ggplot2)
#Read in the NEI and SCC data. Data files must be in the working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset of only the rows of the Source Classification Code data frame that include "Coal" in the Short Name ID
SCC_coal <- SCC[grepl("Coal", SCC$Short.Name), ]

#Subset of only the rows of National Emissions data that contain elements in the SCC_coal data frame.
NEI_coal <- NEI[NEI$SCC %in% SCC_coal$SCC,]

#Plot4 shows the Total PM2.5 Emissions from Coal Sources for the US during the four years 1999, 2002, 2005, 2008.
png("plot4.png", width = 480, height = 480)
g <-
        ggplot(NEI_coal, aes(as.factor(year), Emissions)) + 
        geom_bar(stat = "identity", fill = "red") + 
        labs(title = "Total Emissions from Coal Sources Across US", x = "Year", y = "Total PM2.5 Emissions")
print(g)
dev.off()