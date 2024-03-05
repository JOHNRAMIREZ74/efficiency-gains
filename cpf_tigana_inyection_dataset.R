# Install necessary packages if not already installed
install.packages("GGally")
install.packages("dplyr")
install.packages("stringr")

# Load required packages
library(readxl)
library(tidyverse)
library(GGally)
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)


# Assign the file path to a variable
route <- "/Users/john/data-science/data-gathering/inyeccion.csv"

# Read the data from the CSV file
data <- read.table(route, header = TRUE, sep = ";", dec =".", stringsAsFactors = FALSE)
print(data)

#Display column names and data classes
str(data)

# Convert Date column to appropriate data type with specified format
data$Date <- as.Date(data$Date, format = "%m/%d/%Y")
data$Time <- as.POSIXct(strptime(data$Time, format = "%H:%M:%S"))

# Convert numeric columns to numeric data types
numeric_columns <- c("CM_FI_INY02.DACA.PV", "CM_FI_INY03.DACA.PV", "CM_FI_INY08.DACA.PV", "CM_FI_INY07.DACA.PV")
data[numeric_columns] <- sapply(data[numeric_columns], as.numeric)

# Update column info after conversion
column_classes <- sapply(data, class)
column_info <- data.frame(Column_Name = names(data), Data_Class = column_classes)

# Print the updated column info
print(column_info)

# Get column names
column_names <- names(data)

# Get data classes for each column
column_classes <- sapply(data, class)

# Combine column names and classes
column_info <- data.frame(Column_Name = column_names, Data_Class = column_classes)

# Print the column info
print(column_info)

# Start analyzing your data by performing exploratory data analysis (EDA).

# Summarize Data:
summary(data)
head(data)

# Identify Data Types:
sapply(data, class)

# Handle Missing Values:
sum(is.na(data))

# Remove rows with missing values
data <- na.omit(data)

# Explore Relationships:
columns <- c(1, 2:6)
mapping <- aes(color = CM_FI_INY02.DACA.PV)
ggpairs(data, mapping = TRUE, columns = columns)
