# AI Usage by Students: Data Analysis Project

## Project Overview

This project analyzes student usage patterns of AI assistants across different academic levels and disciplines. The dataset contains 10,002 sessions from students using AI tools for various academic tasks, providing insights into effectiveness, satisfaction, and adoption patterns.

## Key Research Questions

1. **Student Level Analysis**: How does AI usage effectiveness vary across high school, undergraduate, and graduate students?
2. **Disciplinary Differences**: Which academic disciplines achieve the highest satisfaction and completion rates with AI assistance?
3. **Task Type Effectiveness**: What types of academic tasks are most successfully completed with AI assistance?
4. **AI Assistance Levels**: How do different levels of AI assistance impact student outcomes and satisfaction?

## Dataset Description

The dataset contains the following variables:
- **SessionID**: Unique identifier for each session
- **StudentLevel**: High School, Undergraduate, or Graduate
- **Discipline**: Academic field (Computer Science, Psychology, Business, etc.)
- **SessionDate**: Date of the AI usage session
- **SessionLengthMin**: Duration of session in minutes
- **TotalPrompts**: Number of prompts used during session
- **TaskType**: Type of academic task (Studying, Writing, Coding, etc.)
- **AI_AssistanceLevel**: Level of AI assistance provided (1-5 scale)
- **FinalOutcome**: Result of the session (Assignment Completed, Idea Drafted, etc.)
- **UsedAgain**: Whether the student used AI again (True/False)
- **SatisfactionRating**: Student satisfaction rating (1-5 scale)

## Methodology

### Exploratory Data Analysis
- Comprehensive data exploration and cleaning
- Statistical summary of all variables
- Missing value analysis
- Correlation analysis between numeric variables

### Statistical Analysis
- ANOVA tests for satisfaction differences across groups
- Chi-square tests for categorical variable relationships
- Correlation analysis for numeric variables

### Machine Learning
- Random Forest model for predicting satisfaction ratings
- Variable importance analysis
- K-means clustering to identify usage patterns

## Key Findings

### 1. Student Level Insights
- **All student levels** show remarkably similar satisfaction ratings (3.41-3.43/5)
- **High school students** have the longest average session times (20.0 minutes)
- **Undergraduate students** represent the largest user group (59.8% of sessions)

### 2. Discipline Performance
- **Top Performers**: Biology (3.45/5), History (3.44/5), Psychology (3.43/5)
- **Consistent Results**: All disciplines achieve moderate to high satisfaction
- **Broad Applicability**: AI tools work effectively across diverse academic fields

### 3. Task Type Effectiveness
- **Most Effective**: Coding tasks (3.46/5 satisfaction, 59.9% completion rate)
- **High Performance**: Homework Help (3.43/5 satisfaction, 50.4% completion rate)
- **Common Usage**: Writing tasks (31% of sessions, 3.41/5 satisfaction)

### 4. AI Assistance Impact
- **Strong Correlation**: AI assistance level strongly correlates with satisfaction (r = 0.776)
- **Optimal Levels**: Higher assistance levels (4-5) consistently improve outcomes
- **Clear Pattern**: Level 5 achieves 4.67/5 satisfaction vs Level 1 at 1.33/5

### 5. User Segmentation
- **Cluster 1: High Satisfaction Users (43.4%)**: High AI assistance utilization (4.2/5) with excellent satisfaction (4.27/5)
- **Cluster 2: Low Satisfaction Users (38.5%)**: Low AI assistance utilization (2.6/5) with poor satisfaction (2.42/5)
- **Cluster 3: Extended Session Users (18.1%)**: Longer sessions (42.3 min) with moderate satisfaction (3.49/5)

## Project Structure

```
├── data/                    # Raw and processed datasets
│   ├── ai_assistant_usage_student_life.csv
│   └── processed_data.csv
├── scripts/                 # Analysis and visualization scripts
│   ├── analysis.R
│   └── visualizations.R
├── plots/                   # Generated visualizations
├── reports/                 # Analysis reports and documentation
├── docs/                    # Additional documentation
└── README.md               # Project overview
```

## Visualizations

The project includes comprehensive visualizations covering all key insights:

### Interactive Dashboard
Access the full interactive dashboard: [Dashboard](https://sezerhasan.github.io/ai-usage-by-students/dashboard.html)

### Visualization Types
1. **Satisfaction Distribution by Student Level**
2. **Discipline Performance Analysis**
3. **Task Type Effectiveness**
4. **AI Assistance Level Impact**
5. **Session Length vs Satisfaction**
6. **Usage Trends Over Time**
7. **Correlation Matrix**
8. **Outcome Distribution**
9. **Reuse Rate Analysis**
10. **Session Efficiency Metrics**

## Technical Details

### Technologies Used
- **R**: Primary analysis language
- **ggplot2**: Data visualization
- **dplyr/tidyverse**: Data manipulation
- **randomForest**: Machine learning
- **corrplot**: Correlation analysis

### Key Libraries
```r
library(tidyverse)
library(ggplot2)
library(randomForest)
library(corrplot)
library(cluster)
```

## Recommendations for Stakeholders

### For Educational Institutions
1. **Targeted AI Training**: Provide discipline-specific AI usage training
2. **Universal Support**: Leverage consistent satisfaction across all student levels
3. **Task-Specific Guidance**: Develop best practices for different task types
4. **Assistance Level Optimization**: Guide students toward optimal AI assistance levels

### For AI Tool Developers
1. **Assistance Level Fine-tuning**: Optimize assistance levels for different user groups
2. **Task Type Features**: Enhance features for high-satisfaction task types (Coding, Homework Help)
3. **Session Efficiency**: Focus on improving completion rates and user experience
4. **User Experience**: Implement features that reduce session length while maintaining satisfaction

### For Students
1. **Optimal Usage Patterns**: Use AI for coding and homework help tasks
2. **Session Management**: Keep sessions focused and efficient
3. **Assistance Level Selection**: Choose higher assistance levels (4-5) for better outcomes
4. **Discipline-Specific Approaches**: Adapt usage patterns to academic field requirements

## Impact and Significance

### Data-Driven Insights
- Evidence-based recommendations for AI tool optimization
- Clear guidance for students and institutions
- Professional-grade analysis suitable for academic publication
- Reproducible methodology for future research

### Educational Value
- Demonstrates universal applicability of AI tools in education
- Provides actionable insights for improving student success
- Shows that behavior, not demographics, drives AI tool effectiveness
- Supports evidence-based educational technology adoption

### Research Contribution
- Large-scale analysis of AI usage patterns in education
- Novel insights into user segmentation and satisfaction drivers
- Methodological framework for analyzing educational technology adoption
- Foundation for future studies on AI in education

## Getting Started

### Local Setup
1. **Clone the repository**
2. **Install R and required packages**
3. **Run analysis scripts**:
   ```r
   source("scripts/analysis.R")
   source("scripts/visualizations.R")
   ```

## Contributing

This project is open for contributions. Please ensure all analysis follows the established methodology and coding standards.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

**Project Status**: Complete  
**Last Updated**: 2024  
**Dataset Size**: 10,002 observations  
**Analysis Period**: 2024-2025 