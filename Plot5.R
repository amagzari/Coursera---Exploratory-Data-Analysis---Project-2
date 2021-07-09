# Coursera - Johns Hopkins Data Science Specialization
# Course 4 - Exploratory Data Analysis - Project 2

# https://www.coursera.org/learn/exploratory-data-analysis/peer/b5Ecl/course-project-2

# Load necessary packages

library(dplyr)
library(ggplot2)

# 3rd Plot

# Import data from rds files

emi_file <- "summarySCC_PM25.rds"
data <- readRDS(emi_file)

ssc_file <- "Source_Classification_Code.rds"
data_ssc <- readRDS(ssc_file)

# Select rows that contain "Comb" followed by "Coal" in the EI.Sector column

data_coal <- data_ssc[grepl("Comb.*Coal", data_ssc$EI.Sector), ]


# Calculate total coal combustion related emissions by year and plot them accordingly

coal_scc <- unique(data_coal$SCC)
coal_emi <- data[(data$SCC %in% coal_scc), ]
coal_year <- coal_emi %>% group_by(year) %>% summarise(total = sum(Emissions))

png("plot4.png", width = 800, height = 800)

ggplot(coal_year, aes(factor(year), total/1000, label = round(total/1000))) + 
  geom_bar(stat = "identity", fill = "darkred") + 
  ggtitle("Total coal combustion related PM2.5 emissions") + 
  xlab("Year")+ ylab("PM2.5 Emissions [kt]") +
  ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

dev.off()

