library(ggplot2)
#Read in the NEI and SCC data. Data files must be in the working directory.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Create a data frame of the subset of NEI data for Balitmore.
df_bmore <- subset(NEI,
                   fips == "24510")

#Utilize the aggregate function to total the sum of emissions for each year of from the Baltimore data frame by type of emission.
df_type <- aggregate(df_bmore[c("Emissions")],
                     list(type = df_bmore$type, year = df_bmore$year),
                     sum)

#Plot3 shows the total emissions for each year in baltimore as a line graph. Showing how emissions of each type have changed each year.
png("plot3.png", width = 480, height = 480)

qplot(
        x = year,
        y = Emissions,
        main = "Total PM2.5 Emissions for Baltimore City",
        xlab = "Year",
        ylab = "Total PM2.5 Emissions",
        data = df_type,
        color = type,
        geom = "line"
)

dev.off()