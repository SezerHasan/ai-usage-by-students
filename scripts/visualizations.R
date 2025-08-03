# AI Usage by Students - Visualizations
# Author: Data Scientist
# Date: 2024

# Load required libraries
library(tidyverse)
library(ggplot2)
library(dplyr)

# Set theme for professional plots
theme_set(theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    legend.title = element_text(size = 11, face = "bold"),
    legend.text = element_text(size = 10),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90", size = 0.3)
  ))

# Read processed data
data <- read.csv("data/processed_data.csv")
data$SessionDate <- as.Date(data$SessionDate)

# Color palette
colors <- c("#2E86AB", "#A23B72", "#F18F01", "#C73E1D", "#8B5A3C", "#4A90A4")

# 1. Student Level Analysis
p1 <- ggplot(data, aes(x = StudentLevel, y = SatisfactionRating, fill = StudentLevel)) +
  geom_boxplot(alpha = 0.8) +
  scale_fill_manual(values = colors[1:3]) +
  labs(
    title = "Satisfaction Ratings by Student Level",
    x = "Student Level",
    y = "Satisfaction Rating",
    fill = "Student Level"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 2. Discipline Analysis
discipline_summary <- data %>%
  group_by(Discipline) %>%
  summarise(
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    SessionCount = n()
  ) %>%
  arrange(desc(AvgSatisfaction))

p2 <- ggplot(discipline_summary, aes(x = reorder(Discipline, AvgSatisfaction), y = AvgSatisfaction, fill = AvgSatisfaction)) +
  geom_col() +
  scale_fill_gradient(low = "#2E86AB", high = "#A23B72") +
  coord_flip() +
  labs(
    title = "Average Satisfaction by Discipline",
    x = "Discipline",
    y = "Average Satisfaction Rating",
    fill = "Satisfaction"
  ) +
  theme(legend.position = "none")

# 3. Task Type Analysis
task_summary <- data %>%
  group_by(TaskType) %>%
  summarise(
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    TaskCount = n()
  ) %>%
  arrange(desc(AvgSatisfaction))

p3 <- ggplot(task_summary, aes(x = reorder(TaskType, AvgSatisfaction), y = AvgSatisfaction, fill = TaskCount)) +
  geom_col() +
  scale_fill_gradient(low = "#F18F01", high = "#C73E1D") +
  coord_flip() +
  labs(
    title = "Satisfaction by Task Type",
    x = "Task Type",
    y = "Average Satisfaction Rating",
    fill = "Number of Sessions"
  )

# 4. AI Assistance Level Impact
assistance_summary <- data %>%
  group_by(AI_AssistanceLevel) %>%
  summarise(
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE),
    CompletionRate = mean(FinalOutcome == "Assignment Completed", na.rm = TRUE),
    LevelCount = n()
  )

p4 <- ggplot(assistance_summary, aes(x = AI_AssistanceLevel)) +
  geom_line(aes(y = AvgSatisfaction, color = "Satisfaction"), size = 2) +
  geom_line(aes(y = CompletionRate * 5, color = "Completion Rate (scaled)"), size = 2) +
  scale_color_manual(values = c("Satisfaction" = "#2E86AB", "Completion Rate (scaled)" = "#A23B72")) +
  scale_y_continuous(
    name = "Satisfaction Rating",
    sec.axis = sec_axis(~./5, name = "Completion Rate")
  ) +
  labs(
    title = "AI Assistance Level Impact",
    x = "AI Assistance Level",
    color = "Metric"
  )

# 5. Session Length vs Satisfaction
p5 <- ggplot(data, aes(x = SessionLengthMin, y = SatisfactionRating, color = StudentLevel)) +
  geom_point(alpha = 0.6, size = 2) +
  geom_smooth(method = "loess", se = TRUE, alpha = 0.3) +
  scale_color_manual(values = colors[1:3]) +
  labs(
    title = "Session Length vs Satisfaction Rating",
    x = "Session Length (minutes)",
    y = "Satisfaction Rating",
    color = "Student Level"
  )

# 6. Usage Over Time
time_series <- data %>%
  group_by(SessionDate) %>%
  summarise(
    DailySessions = n(),
    AvgSatisfaction = mean(SatisfactionRating, na.rm = TRUE)
  )

p6 <- ggplot(time_series, aes(x = SessionDate)) +
  geom_line(aes(y = DailySessions, color = "Daily Sessions"), size = 1.2) +
  geom_line(aes(y = AvgSatisfaction * 20, color = "Avg Satisfaction (scaled)"), size = 1.2) +
  scale_color_manual(values = c("Daily Sessions" = "#2E86AB", "Avg Satisfaction (scaled)" = "#A23B72")) +
  scale_y_continuous(
    name = "Daily Sessions",
    sec.axis = sec_axis(~./20, name = "Average Satisfaction")
  ) +
  labs(
    title = "Usage Trends Over Time",
    x = "Date",
    color = "Metric"
  )

# 7. Correlation Heatmap
numeric_data <- data %>%
  select(SessionLengthMin, TotalPrompts, AI_AssistanceLevel, SatisfactionRating) %>%
  na.omit()

correlation_matrix <- cor(numeric_data)
correlation_df <- as.data.frame(as.table(correlation_matrix))
names(correlation_df) <- c("Var1", "Var2", "Correlation")

p7 <- ggplot(correlation_df, aes(x = Var1, y = Var2, fill = Correlation)) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.2f", Correlation)), color = "white", size = 4) +
  scale_fill_gradient2(low = "#C73E1D", mid = "white", high = "#2E86AB", midpoint = 0) +
  labs(
    title = "Correlation Matrix",
    x = "",
    y = "",
    fill = "Correlation"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 8. Outcome Distribution
outcome_summary <- data %>%
  group_by(FinalOutcome) %>%
  summarise(Count = n()) %>%
  mutate(Percentage = Count / sum(Count) * 100)

p8 <- ggplot(outcome_summary, aes(x = "", y = Percentage, fill = FinalOutcome)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = colors) +
  labs(
    title = "Distribution of Final Outcomes",
    x = "",
    y = "",
    fill = "Outcome"
  ) +
  theme_void()

# 9. Reuse Rate by Discipline
reuse_summary <- data %>%
  group_by(Discipline) %>%
  summarise(
    ReuseRate = mean(UsedAgain == "True", na.rm = TRUE),
    SessionCount = n()
  ) %>%
  filter(SessionCount >= 50) %>%  # Filter for disciplines with sufficient data
  arrange(desc(ReuseRate))

p9 <- ggplot(reuse_summary, aes(x = reorder(Discipline, ReuseRate), y = ReuseRate, fill = SessionCount)) +
  geom_col() +
  scale_fill_gradient(low = "#8B5A3C", high = "#4A90A4") +
  coord_flip() +
  labs(
    title = "AI Tool Reuse Rate by Discipline",
    x = "Discipline",
    y = "Reuse Rate",
    fill = "Session Count"
  )

# 10. Session Efficiency Analysis
p10 <- ggplot(data, aes(x = SessionEfficiency, y = SatisfactionRating, color = StudentLevel)) +
  geom_point(alpha = 0.6, size = 2) +
  geom_smooth(method = "loess", se = TRUE, alpha = 0.3) +
  scale_color_manual(values = colors[1:3]) +
  labs(
    title = "Session Efficiency vs Satisfaction",
    x = "Prompts per Minute",
    y = "Satisfaction Rating",
    color = "Student Level"
  ) +
  xlim(0, quantile(data$SessionEfficiency, 0.95, na.rm = TRUE))  # Remove outliers

# Save individual plots
ggsave("plots/student_level_satisfaction.png", p1, width = 10, height = 6, dpi = 300)
ggsave("plots/discipline_satisfaction.png", p2, width = 10, height = 8, dpi = 300)
ggsave("plots/task_type_satisfaction.png", p3, width = 10, height = 8, dpi = 300)
ggsave("plots/assistance_level_impact.png", p4, width = 10, height = 6, dpi = 300)
ggsave("plots/session_length_satisfaction.png", p5, width = 10, height = 6, dpi = 300)
ggsave("plots/usage_trends.png", p6, width = 12, height = 6, dpi = 300)
ggsave("plots/correlation_matrix.png", p7, width = 8, height = 8, dpi = 300)
ggsave("plots/outcome_distribution.png", p8, width = 8, height = 8, dpi = 300)
ggsave("plots/reuse_rate_discipline.png", p9, width = 10, height = 8, dpi = 300)
ggsave("plots/session_efficiency.png", p10, width = 10, height = 6, dpi = 300)

cat("All visualizations saved to 'plots/' directory\n") 