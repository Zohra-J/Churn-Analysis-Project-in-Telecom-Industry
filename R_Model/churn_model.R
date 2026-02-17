R_Model/churn_model.R
# Customer Churn Prediction Model
# Project: Telecom Customer Churn Analysis
# Tools Used:
#   - SQL: Data cleaning and preparation
#   - Tableau: Exploratory analysis and visualization
#   - R: Predictive modelling (Logistic Regression)

# 1. Load Required Libraries

install.packages("readr")
install.packages("dplyr")
install.packages("caTools")
install.packages("caret")
install.packages("pROC")

library(readr)
library(dplyr)
library(caTools)
library(caret)
library(pROC)

# 2. Import Dataset
data <- read_csv("Dataset/teleco_churn.csv") 

head(data)
str(data)

# 3. Data Preparation
# Convert target variable to factor
data$Churn <- as.factor(data$Churn)

# Remove customer ID (not predictive)
data$customerID <- NULL

# Remove missing values
data <- na.omit(data)

# 4. Train/Test Split
set.seed(123)

split <- sample.split(data$Churn, SplitRatio = 0.7)

train <- subset(data, split == TRUE)
test  <- subset(data, split == FALSE)


# 5. Logistic Regression Model

model <- glm(
  Churn ~ tenure + MonthlyCharges + TotalCharges + Contract,
  data = train,
  family = binomial
)
summary(model)

# 6. Predictions

probabilities <- predict(model, newdata = test, type = "response")

predicted <- ifelse(probabilities > 0.5, "Yes", "No")
predicted <- as.factor(predicted)


# 7. Model Evaluation
# Confusion Matrix
table(Predicted = predicted, Actual = test$Churn)

# Accuracy
mean(predicted == test$Churn)

# Detailed metrics (Precision, Recall, F1)
confusionMatrix(predicted, test$Churn)


# 8. ROC Curve & AUC Score
roc_curve <- roc(test$Churn, probabilities)
plot(roc_curve)  
auc(roc_curve)
