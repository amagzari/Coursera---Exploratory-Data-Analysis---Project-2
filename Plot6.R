# Coursera - Johns Hopkins Data Science Specialization
# Course 4 - Exploratory Data Analysis - Project 2

# https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2

# Load necessary packages

library(dplyr)
library(ggplot2)

# 5th Plot

# Import data from rds files

emi_file <- "summarySCC_PM25.rds"
data <- readRDS(emi_file)

ssc_file <- "Source_Classification_Code.rds"
data_ssc <- readRDS(ssc_file)

# Select only rows related to motor vehicle sources

data_motor <- data_ssc[grepl("Vehicle", data_ssc$SCC.Level.Two), ]


# Calculate total motor vehicle emissions in Baltimore City by year and plot them accordingly

motor_scc <- unique(data_motor$SCC)
motor_emi <- data[(data$SCC %in% motor_scc), ]

balti_la_year <- motor_emi %>% filter(fips == "24510" | fips == "06037") %>% group_by(fips, year) %>% summarise(total = sum(Emissions))
balti_la_year <- mutate(balti_la_year, location = ifelse(fips == "24510", "Baltimore City", ifelse(fips == "06037", "Los Angelse County")))

# png("plot6.png", width = 480, height = 480)

ggplot(balti_la_year, aes(factor(year), total, fill = location)) + 
  geom_bar(stat = "identity") + facet_grid(. ~ location) + 
  ggtitle("Total PM2.5 emissions in Baltimore City and Los Angeles County") +
  xlab("Year") + ylab("Pm2.5 Emissions in tonnes") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme_classic() 

ggplot(emi_balt_t, aes(x = factor(year), y = total, fill = type)) + 
  geom_bar(stat = "identity") + facet_grid(. ~ type) + 
  ggtitle("Total PM2.5 emissions in Baltimore City, Maryland") + 
  xlab("Year")+ ylab("PM2.5 Emissions in tonnes") +
  theme_classic() + theme(plot.title = element_text(hjust = 0.5))
scale_fill_brewer(palette = "Set1")

  geom_bar(stat = "identity", fill = "darkred") + 
  ggtitle("Total Motor Vehicle Emissions in Baltimore City") + 
  xlab("Year")+ ylab("PM2.5 Emissions in Tonnes") +
  ylim(c(0, 450)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

dev.off()

