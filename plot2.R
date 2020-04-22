#Read in the NEI and SCC data. Data files must be in the working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create a data frame of the subset of NEI data for Balitmore
df_bmore <- subset(NEI, fips == "24510")

#We compute the sum total of emissions indexed by year for Baltimore City.
total_bmore_emissions <-
        tapply(df_bmore$Emissions, INDEX = df_bmore$year, FUN = sum)

#Plot2 shows the total emissions for 1999, 2002, 2005, and 2008 for Baltimore City as a bar plot.
png("plot2.png", width = 480, height = 480)

barplot(
        total_bmore_emissions,
        main = "Total Emissions for Baltimore City",
        col = "red",
        xlab = "year",
        ylab = "Total PM2.5 Emissions"
)

dev.off()