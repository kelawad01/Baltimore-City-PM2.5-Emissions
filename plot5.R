library(ggplot2)
#Read in the NEI and SCC data. Data files must be in the working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset of only the rows of the Source Classification Code data frame that include "Vehicle" in the level two classifications
SCC_motor <- SCC[grepl("Vehicle", SCC$SCC.Level.Two),]

#Subset of only the rows of National Emissions data that contain elements in the SCC_motor data frame.
NEI_motor <- NEI[NEI$SCC %in% SCC_motor$SCC,]

#Create a data frame containing only emissions from motor vehicles in Baltimore
NEI_motor_bmore <- subset(NEI_motor,
                          fips == "24510")

#Plot5 the Total Emissions from Motor Vehicles in Baltimore for the four years 1999, 2002, 2005, and 2008
png("plot5.png", width = 480, height = 480)
g <-
        ggplot(NEI_motor_bmore, aes(as.factor(year), Emissions)) +
        geom_bar(stat = "identity", fill = "red") + 
        labs(title = "Total Motor Vehicle Emissions for Baltimore City", x = "Year", y = "Total PM2.5 Emissions")

print(g)

dev.off()