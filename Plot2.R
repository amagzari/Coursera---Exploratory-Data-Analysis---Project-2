# Coursera - Johns Hopkins Data Science Specialization
# Course 4 - Exploratory Data Analysis - Project 2

# https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2

# Load necessary packages

library(dplyr)

# 2nd Plot

# Import data from rds file

file_name <- "summarySCC_PM25.rds"
data <- readRDS(file_name)

# Calculate total emissions by year for Baltimore City and plot them accordingly 

emi_balt <- data %>% group_by(year) %>% filter(fips == "24510") %>% summarise(total = sum(Emissions))

png("plot2.png", width = 480, height = 480)
  
plot2 <- barplot(emi_balt$total, main = "Total PM2.5 emissions in Baltimore City, Maryland", 
                 xlab = "Year", ylab = "PM2.5 Emissions in tonnes", names.arg = emi_balt$year,
                 col = "darkred", ylim = c(0,3600))

text(plot2, round(emi_balt$total), label = round(emi_balt$total), 
     pos = 3, cex = 1.2)

dev.off()