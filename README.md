# Video Game Scores and Sales Analysis

Author: Arianna Rigamonti

## Overview
This project analyzes video game scores and sales data to examine trends and relationships between critic and user ratings and market performance. The dataset includes information on game releases, platforms, genres, sales in different regions, and review scores. Using statistical techniques, the analysis explores score distributions, sales trends, and performs hypothesis testing to validate assumptions about video game success.

## Objectives
- Perform descriptive analysis to examine distributions of game releases, critic scores, user scores, and sales across regions.
- Conduct hypothesis testing to compare critic scores and sales across different game genres.
- Identify correlations between critic scores, user scores, and sales performance.
- Develop regression models to predict global sales based on critic and user scores.

## Features
- Data Cleaning and Preparation: Handles missing values and structures the dataset for analysis.
- Visualizations: Generates histograms, boxplots, and correlation matrices for data exploration.
- Statistical Tests: Performs hypothesis testing to compare sales and scores across different game genres.
- Regression Models: Implements linear and polynomial regression models to analyze the impact of review scores on sales performance.

## Technologies Used
- R programming for statistical analysis and data visualization
- ggplot2 for data visualization
- dplyr for data manipulation
- BSDA and nortest for hypothesis testing
- ggcorrplot for correlation analysis

## Dataset
The dataset used in this analysis contains:
- Game Metadata: Name, Platform, Year of Release, Genre, Publisher, Developer, Rating.
- Sales Data: Sales in North America, Europe, Japan, Other regions, and globally.
- Review Scores: Critic Scores, Critic Count, User Scores, and User Count.

## Installation
To run this project, ensure you have R installed along with the required packages:

```r
install.packages(c("psych", "ggplot2", "ggcorrplot", "dplyr", "ggpubr", "rlist", 
                   "stringi", "BSDA", "nortest"))
```

## Usage

1.	Clone the repository

```bash
git clone https://github.com/yourusername/video-game-sales-analysis.git
cd video-game-sales-analysis
```
2.	Load the dataset (Video_Games.csv) into R.
3.	Run the analysis.R script to generate visualizations and statistical insights.

## Analysis Highlights
- Comparison of critic and user scores, including their distributions and correlation.
- Examination of sales performance by region and genre.
- Hypothesis testing:
  - Comparing mean critic scores between Role-Playing and Action games.
  - Analyzing whether critic scores influence sales differently across genres.
  - Testing if higher critic scores correspond to significantly higher sales.
- Regression Models:
  - Predicting global sales using critic and user scores.
  - Applying logarithmic and polynomial transformations to improve prediction accuracy.

## Results and Insights
- Games with higher critic scores generally achieve better sales, but the relationship is non-linear.
- Action games maintain strong sales despite lower critic scores, suggesting other market factors influence their success.
- Critic and user scores alone do not fully explain sales trends, indicating that additional elements such as marketing, brand recognition, and platform availability contribute to performance.

## Future Improvements
- Incorporate additional factors such as marketing budget, online reviews, and social media impact.
- Apply machine learning techniques to enhance predictive modeling.
- Expand the dataset with more recent releases and detailed regional breakdowns.
