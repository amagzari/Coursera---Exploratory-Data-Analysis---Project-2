# Coursera - Johns Hopkins Data Science Specialization
# Course 4 - Exploratory Data Analysis - Project 2

# https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2

# Load necessary packages

library(dplyr)
library(ggplot2)

# 3rd Plot

# Import data from rds file

file_name <- "summarySCC_PM25.rds"
data <- readRDS(file_name)

# Calculate total emissions by year and source type for Baltimore City and plot them accordingly

emi_balt_t <- data %>% group_by(type, year) %>% filter(fips == "24510") %>% summarise(total = sum(Emissions))

png("plot3.png", width = 800, height = 800)

ggplot(emi_balt_t, aes(x = factor(year), y = total, fill = type)) + 
  geom_bar(stat = "identity") + facet_grid(. ~ type) + 
  ggtitle("Total PM2.5 emissions in Baltimore City, Maryland") + 
  xlab("Year")+ ylab("PM2.5 Emissions in tonnes") +
  theme_classic() + theme(plot.title = element_text(hjust = 0.5))
  scale_fill_brewer(palette = "Set1")

dev.off()

