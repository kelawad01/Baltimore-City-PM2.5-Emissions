#Read in the NEI and SCC data. Data files must be in the working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#We compute the sum total of emissions indexed by year.
total_emissions <-
        tapply(NEI$Emissions, INDEX = NEI$year, FUN = sum)

#Plot1 shows the total emissions for 1999, 2002, 2005, and 2008 as a bar plot.
png("plot1.png", width = 480, height = 480)

barplot(
        total_emissions,
        main = "Total PM2.5 Emissions",
        col = "red",
        xlab = "year",
        ylab = "Total PM2.5 Emissions"
)

dev.off()