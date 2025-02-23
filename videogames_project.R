##########################################################
###                                                      ###
###        VIDEOGAMES: SCORES AND SALES ANALYSIS           ###
###                                                      ###
#########################################################

# Load required libraries
library(psych)
library(ggplot2) 
library(ggcorrplot) # For the correlation map
library(dplyr) # For sample_n function (samples rows instead of columns)
library(ggpubr) # For qqplot
library(rlist)
library(stringi)
library(BSDA) # For z-test
library(nortest)

# Load dataset
df <- read.csv("Video_Games.csv")
str(df)

# Convert User_Score to numeric
df$User_Score <- as.numeric(df$User_Score)
str(df)

# Extract relevant columns
Name <- df$Name
Platform <- df$Platform
Year_of_Release <- df$Year_of_Release
Genre <- df$Genre
Publisher <- df$Publisher
NA_Sales <- df$NA_Sales
EU_Sales <- df$EU_Sales
JP_Sales <- df$JP_Sales
Other_Sales <- df$Other_Sales
Global_Sales <- df$Global_Sales
Critic_Score <- df$Critic_Score
Critic_Count <- df$Critic_Count
User_Score <- df$User_Score
User_Count <- df$User_Count
Developer <- df$Developer
Rating <- df$Rating

# Remove missing data (NA values)
n_df <- na.omit(data.frame(Name, Platform, Year_of_Release, Genre, Publisher, NA_Sales, EU_Sales,
                           JP_Sales, Other_Sales, Global_Sales, Critic_Score, Critic_Count, User_Score,
                           User_Count, Developer, Rating))

###########################################################
#                  DESCRIPTIVE ANALYSIS                   #
###########################################################

# RELEASING YEAR (df)
hist(n_df$Year_of_Release,
     xlim = c(1995,2020),
     ylim = c(0,400),
     xlab = "Release Year",
     ylab = "Number of Games",
     main = "Annual Distribution of Games",
     col = "skyblue")  

boxplot(n_df$Year_of_Release, col = "lightblue", main = "Distribution of Release Year")

# CRITIC SCORE (n_df)
hist(n_df$Critic_Score, 
     ylim = c(0,1200),
     xlab = 'Critic Scores', 
     ylab = 'Frequencies', 
     main = "Histogram of Critic Scores", 
     col = "skyblue")

boxplot(n_df$Critic_Score, col = "lightblue", main = "Distribution of Critic Scores")

# Log-transformed Critic Scores
log_critic_s <- log1p(n_df$Critic_Score)
hist(log_critic_s,
     xlim = c(3, 5),
     ylim = c(0,2000),
     xlab = 'Log-transformed Critic Scores', 
     ylab = 'Frequencies', 
     main = "Histogram of Log-transformed Critic Scores", 
     col = "skyblue",
     breaks = 20)

# USER SCORE (n_df)
hist(n_df$User_Score,
     xlab = 'User Scores', 
     ylab = 'Frequencies', 
     main = "Histogram of User Scores", 
     col = "lightgreen")

boxplot(n_df$User_Score, col = "lightgreen", main = "Distribution of User Scores")

# GLOBAL SALES
hist(n_df$Global_Sales,
     xlim = c(0, 2.5),
     ylim = c(0,3000),
     xlab = "Global Sales (millions)",
     main = "Distribution of Global Sales",
     col = "orange",
     breaks = 300)

boxplot(n_df$Global_Sales, col = "orange", main = "Distribution of Global Sales")

# NA SALES
hist(n_df$NA_Sales, 
     xlim = c(0, 2.5),
     ylim = c(0,5000),
     xlab = "NA Sales (millions)", 
     main = "Distribution of NA Sales",
     col = "magenta",
     breaks = 200)

boxplot(n_df$NA_Sales, col = "magenta", main = "Distribution of NA Sales")

# EU SALES
hist(n_df$EU_Sales, 
     xlim = c(0, 1.2),
     ylim = c(0,5000),
     xlab = "EU Sales (millions)", 
     main = "Distribution of EU Sales",
     col = "lightgreen",
     breaks = 300)

boxplot(n_df$EU_Sales, col = "lightgreen", main = "Distribution of EU Sales")

# GENRE PIE CHART
pie(table(Genre), col = rainbow(length(unique(Genre))), main = "Genre Pie Chart")

# CORRELATION MATRIX
num_n_df <- na.omit(data.frame(Year_of_Release, NA_Sales, EU_Sales, Global_Sales, Critic_Score, User_Score))
corr_mat <- cor(num_n_df)

ggcorrplot(corr_mat, type = "lower", show.legend = TRUE) + 
  ggtitle("Correlation Matrix") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#############################################################################
#                            HYPOTHESIS TESTING                              #
#############################################################################

# Select relevant columns
df2 <- na.omit(n_df[c("Genre", "Critic_Score")])

# Distribution of genres
table(df2$Genre)

# Calculate mean critic scores per genre
df2_means <- as.data.frame(aggregate(. ~ Genre, data = df2, mean))
print(df2_means)

# Hypothesis Test 1: Comparing Role-Playing Games Critic Score to Population Mean
s <- sample_n(df2, size = 1000)

# Extract Critic Scores for Role-Playing genre
rs <- na.omit(s$Critic_Score[s$Genre == "Role-Playing"])

# T-test
t_test_result <- t.test(rs, mu = 72.90759, conf.level = 0.95)
print(t_test_result)

# Population standard deviation
population_sd <- sd(rs)
print(population_sd)

# Z-test
z_test_result <- z.test(rs, mu = 72.90759, sigma.x = population_sd, conf.level = 0.95)
print(z_test_result)

#############################################################################

# Hypothesis Test 2: Comparing Critic Scores of Role-Playing vs. Action Games
rp <- s$Critic_Score[s$Genre == "Role-Playing"]
a <- s$Critic_Score[s$Genre == "Action"]

# Remove missing values
rp <- rp[rp > 0]
a <- a[a > 0]

# T-test
t_test_result <- t.test(rp, a, alternative = "greater", conf.level = 0.95)
print(t_test_result)

#############################################################################

# Hypothesis Test 3: Comparing Sales of Action vs. Role-Playing Games
df3 <- n_df[c("Genre", "NA_Sales")]
df3$Genre <- ifelse(df3$Genre == "", "Other", df3$Genre)

# Sample 1000 observations
s1 <- sample_n(df3, size = 1000)

# Extract sales data
rp_sales <- s1$NA_Sales[s1$Genre == "Role-Playing"]
a_sales <- s1$NA_Sales[s1$Genre == "Action"]

# T-test
t_test_result <- t.test(rp_sales, a_sales, alternative = "greater", conf.level = 0.95)
print(t_test_result)

#############################################################################
#                            LINEAR REGRESSION                               #
#############################################################################

# Create a linear regression model (Critic Score vs Global Sales)
model_critic <- lm(Global_Sales ~ Critic_Score, data = n_df)
summary(model_critic)

# Plot the regression line
plot(n_df$Critic_Score, n_df$Global_Sales, main = "Critic Score vs Global Sales")
abline(model_critic, col = "red")

# Residual normality test
shapiro_test_result <- shapiro.test(resid(model_critic))
print(shapiro_test_result)

#############################################################################