# Coursera - Johns Hopkins Data Science Specialization
# Course 4 - Exploratory Data Analysis - Project 2

# https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2

# Load necessary packages

library(dplyr)

# 1st Plot

# Import data from rds file

file_name <- "summarySCC_PM25.rds"
data <- readRDS(file_name)

# Calculate total emissions by year and plot them accordingly

emi_year <- data %>% group_by(year) %>% summarise(total = sum(Emissions))

png("plot1.png", width = 480, height = 480)

plot1 <- barplot(emi_year$total/1000, main = "Total PM2.5 emissions by year", 
                 xlab = "Year", ylab = "PM2.5 Emissions [kt]", names.arg = emi_year$year,
                 col = "darkred", ylim = c(0,8000))

text(plot1, round(emi_year$total/1000), label = round(emi_year$total/1000), 
     pos = 3, cex = 1.2)

dev.off()