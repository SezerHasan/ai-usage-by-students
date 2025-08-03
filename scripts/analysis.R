# AI Usage by Students - Data Analysis
# Author: Hasan Sezer
# Date: 2025

# Load required libraries
library(tidyverse)
library(ggplot2)
library(dplyr)

# Set seed for reproducibility
set.seed(123)

# Read the dataset
data <- read.csv("data/ai_assistant_usage_student_life.csv")

# Basic data exploration
cat("Dataset Overview:\n")
cat("Number of observations:", nrow(data), "\n")
cat("Number of variables:", ncol(data), "\n")
cat("\nVariable names:\n")
print(names(data))

# Data structure
cat("\nData structure:\n")
str(data)

# Summary statistics
cat("\nSummary statistics:\n")
summary(data)

# Check for missing values
cat("\nMissing values:\n")
missing_summary <- colSums(is.na(data))
print(missing_summary)

# Convert date column to proper format
data$SessionDate <- as.Date(data$SessionDate)

# Create derived variables
data$Month <- format(data$SessionDate, "%m")
data$Year <- format(data$SessionDate, "%Y")
data$DayOfWeek <- weekdays(data$SessionDate)
data$SessionEfficiency <- data$TotalPrompts / data$SessionLengthMin

# Research Questions Analysis

# 1. How does AI usage vary across student levels?
cat("\n=== Research Question 1: AI Usage by Student Level ===\n")
usage_by_level <- data %>%
  group_by(StudentLevel) %>%
  summarise(
    AvgSessionLength = mean(SessionLengthMin, na.rm = TRUE),
    AvgPrompts = mean(TotalPrompts, na.rm = TRUE),
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    UsageCount = n(),
    ReuseRate = mean(UsedAgain == "True", na.rm = TRUE)
  )
print(usage_by_level)

# 2. Which disciplines use AI most effectively?
cat("\n=== Research Question 2: AI Usage by Discipline ===\n")
discipline_analysis <- data %>%
  group_by(Discipline) %>%
  summarise(
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    AvgEfficiency = mean(SessionEfficiency, na.rm = TRUE),
    CompletionRate = mean(FinalOutcome == "Assignment Completed", na.rm = TRUE),
    SessionCount = n()
  ) %>%
  arrange(desc(AvgSatisfaction))
print(discipline_analysis)

# 3. What task types are most successful with AI assistance?
cat("\n=== Research Question 3: Task Type Analysis ===\n")
task_analysis <- data %>%
  group_by(TaskType) %>%
  summarise(
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    CompletionRate = mean(FinalOutcome == "Assignment Completed", na.rm = TRUE),
    AvgSessionLength = mean(SessionLengthMin, na.rm = TRUE),
    TaskCount = n()
  ) %>%
  arrange(desc(AvgSatisfaction))
print(task_analysis)

# 4. How does AI assistance level affect outcomes?
cat("\n=== Research Question 4: AI Assistance Level Impact ===\n")
assistance_analysis <- data %>%
  group_by(AI_AssistanceLevel) %>%
  summarise(
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    CompletionRate = mean(FinalOutcome == "Assignment Completed", na.rm = TRUE),
    ReuseRate = mean(UsedAgain == "True", na.rm = TRUE),
    LevelCount = n()
  ) %>%
  arrange(AI_AssistanceLevel)
print(assistance_analysis)

# Statistical Analysis

# Correlation analysis
cat("\n=== Correlation Analysis ===\n")
numeric_data <- data %>%
  select(SessionLengthMin, TotalPrompts, AI_AssistanceLevel, SatisfactionRating) %>%
  na.omit()

correlation_matrix <- cor(numeric_data)
print(round(correlation_matrix, 3))

# ANOVA tests
cat("\n=== ANOVA Tests ===\n")

# Satisfaction by student level
satisfaction_anova <- aov(SatisfactionRating ~ StudentLevel, data = data)
cat("Satisfaction by Student Level (ANOVA):\n")
print(summary(satisfaction_anova))

# Satisfaction by discipline
discipline_anova <- aov(SatisfactionRating ~ Discipline, data = data)
cat("\nSatisfaction by Discipline (ANOVA):\n")
print(summary(discipline_anova))

# Chi-square tests
cat("\n=== Chi-Square Tests ===\n")

# Final outcome vs student level
outcome_level_table <- table(data$FinalOutcome, data$StudentLevel)
outcome_level_chi <- chisq.test(outcome_level_table)
cat("Final Outcome vs Student Level (Chi-square):\n")
print(outcome_level_chi)

# Used again vs discipline
reuse_discipline_table <- table(data$UsedAgain, data$Discipline)
reuse_discipline_chi <- chisq.test(reuse_discipline_table)
cat("\nUsed Again vs Discipline (Chi-square):\n")
print(reuse_discipline_chi)

# Basic clustering analysis using kmeans
cat("\n=== Basic Clustering Analysis ===\n")

# Prepare data for clustering
cluster_data <- data %>%
  select(SessionLengthMin, TotalPrompts, AI_AssistanceLevel, SatisfactionRating) %>%
  scale() %>%
  na.omit()

# K-means clustering
kmeans_result <- kmeans(cluster_data, centers = 3, nstart = 25)
data$Cluster <- kmeans_result$cluster

cluster_summary <- data %>%
  group_by(Cluster) %>%
  summarise(
    AvgSessionLength = mean(SessionLengthMin, na.rm = TRUE),
    AvgPrompts = mean(TotalPrompts, na.rm = TRUE),
    AvgAssistanceLevel = mean(AI_AssistanceLevel, na.rm = TRUE),
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    ClusterSize = n()
  )
print(cluster_summary)

# Save processed data
write.csv(data, "data/processed_data.csv", row.names = FALSE)

cat("\nAnalysis complete! Processed data saved to 'data/processed_data.csv'\n") 
