library(ggplot2)
#Read in the NEI and SCC data. Data files must be in the working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset of only the rows of the Source Classification Code data frame that include "Vehicle" in the level two classifications
SCC_motor <- SCC[grepl("Vehicle", SCC$SCC.Level.Two), ]

#Subset of only the rows of National Emissions data that contain elements in the SCC_motor data frame.
NEI_motor <- NEI[NEI$SCC %in% SCC_motor$SCC, ]

#Create a data frame containing only emissions from motor vehicles in Baltimore
NEI_motor_bmore <- subset(
        NEI_motor,
        fips == "24510"
)

#Create a data frame containing only emissions from motor vehicles in Los Angeles
NEI_motor_lac <- subset(
        NEI_motor,
        fips == "06037"
)

#Row bind the LA County motor vehicle emissions data with the Baltimore motor vehicle emissions data 
NEI_motor_both <- rbind(NEI_motor_bmore, NEI_motor_lac)

#Replacing the fips identifier for each city with the city name. This will aid with generating the bar graph for comparison.
NEI_motor_both$fips[NEI_motor_both$fips == "24510"] <- "Baltimore"
NEI_motor_both$fips[NEI_motor_both$fips == "06037"] <- "Los Angeles"

#Plot6 shows the comparison motor vehicle emissions data for Baltimore and Los Angeles as a bar plot with facet grids by city.
png("plot6.png", width = 480, height = 480)

g <- ggplot(NEI_motor_both, aes(as.factor(year), Emissions, fill = fips)) + geom_bar(stat = "identity") + facet_grid(.~fips) + labs(title = "Motor Vehicle Emissions Data for Baltimore and Los Angeles", x = "Year", y = "Total PM2.5 Emissions")

print(g)

dev.off()


