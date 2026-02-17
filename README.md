# Churn-Analysis-Project-in-Telecom-Industry
In competitive industries like telecoms, retaining customers is as vital as gaining them. Using real-world data, this churn research project analyzes why users leave and how to stop it. By leveraging machine learning and predictive modeling, I translate data into business strategies, creating a framework to maintain an engaged, loyal customer base.
Customer-Churn-Analysis/
│
├── README.md
│
├── SQL/
│   ├── data_cleaning.sql
│   └── eda_queries.sql
│
├── Tableau/
│   ├── churn_dashboard.twbx
│   └── dashboard_screenshots/
│
├── R_Model/
│   ├── churn_model.R
│   └── model_output_screenshot.png (optional)
│
└── Dataset/


Problem Framing — Customer Churn Analysis
Business Context

This project analyses customer behaviour in a subscription-based telecom business offering phone, internet, and value-added services. Customers pay recurring monthly charges under different contract types and can cancel their service depending on contract terms.

What is Churn?

In this dataset:
Churn = Yes → Customer has cancelled their subscription
Churn = No → Customer is still active
Customer churn therefore represents the loss of existing subscribers during a given period.

Why Churn Matters?
Churn is one of the most critical metrics in subscription businesses because:
Revenue loss: Each churned customer reduces recurring income.
Higher acquisition costs: Attracting new customers usually costs more than retaining current ones.
Customer experience insights: Churn may indicate issues with pricing, service quality, support, or engagement.
Strategic decision-making: Understanding churn helps prioritise retention campaigns and improve customer satisfaction.

Project Objective

The main goal of this analysis is to:
Identify factors influencing customer churn
Analyse usage, tenure, and engagement patterns
Build insights to help reduce churn
Support data-driven retention strategies

Key Questions Explored

Do contract types influence churn risk?
Are higher monthly charges linked to churn?
Does shorter customer tenure increase churn probability?
How do service usage and support features affect retention?

Data Cleaning

Missing values were identified primarily in the TotalCharges column.
Blank entries were converted to NULL values for consistency.
This ensures accurate numerical analysis and prevents errors during modelling.

Fix data types

Incorrect data types were identified after CSV import.
The TotalCharges column was converted from text to numeric.
Numeric columns were standardised for accurate calculations.
Dataset is now ready for exploratory analysis and modelling.

Validate Target Variable (Churn) in MySQL Workbench.

This ensures dependent variable (Churn) is clean and reliable before analysis or modelling.Validating the target variable is critical because incorrect labels can lead to misleading insights and inaccurate predictive models.
The churn column was validated to ensure consistency.
No unexpected categories or missing values were found.
The dataset is now reliable for churn analysis.

Step 3- Exploratory Data Analysis (EDA)
Exploratory Data Analysis was conducted using MySQL Workbench for querying and Tableau for visualization to understand customer churn behaviour, usage patterns, and engagement trends. The goal was to identify factors influencing customer retention and churn risk.
a) Churn vs non-churn comparison
       Key comparisons were made between customers who churned and those who stayed:
       Calculated overall churn rate and customer distribution.
       Compared average monthly and total charges between churned and retained customers.
       Analysed churn across different contract types (month-to-month vs long-term contracts).
       Examined churn variation by internet service type.
       Compared average customer tenure between churned and retained groups.
Key observation:
      Customers with shorter contracts, higher monthly charges, and shorter tenure showed higher churn likelihood.

b) Usage, Tenure & Engagement Patterns
      Customer engagement behaviour was analysed to identify churn drivers:
      Grouped customers by tenure to identify lifecycle churn patterns.
      Analysed adoption of services such as:
      Tech support
      Online security
      Streaming services
      Device protection
      Evaluated payment methods and their association with churn.
      Assessed how service usage intensity impacts customer retention.
Key observation:
      Customers with lower service engagement, limited support features, and shorter tenure tended to churn more frequently.

Visualization (Tableau)
     Interactive dashboards were created to:
     Compare churn vs non-churn customer segments
     Visualize tenure distribution and service adoption
     Highlight key churn risk indicators
These visuals helped translate SQL findings into business insights.

Outcome of EDA
    The exploratory analysis:
    Identified behavioural and contractual drivers of churn
    Highlighted high-risk customer segments
    Provided direction for feature engineering and churn prediction modelling
    Generated actionable insights for retention strategies

Step 4 — Feature Engineering
Feature engineering was performed using MySQL Workbench to create new variables that better explain customer churn behaviour. These derived features help uncover hidden patterns, improve segmentation, and support deeper business insights.

Customer Tenure Features
   Customer tenure was grouped to identify lifecycle churn patterns:
   Created tenure categories (e.g., 0–12 months, 13–24 months, 25–48 months, 48+ months).
   Helps identify early churn risk and long-term customer stability.
   Useful for retention targeting and lifecycle analysis.

Contract Commitment Indicators
   Contract information was transformed into engagement indicators:
   Identified customers on month-to-month contracts vs longer commitments.
   Longer contracts typically indicate stronger customer loyalty.
   Helps highlight customers at higher churn risk.

Customer Spending Behaviour
   Spending-related features were analysed:
   Average monthly charges used as a proxy for pricing sensitivity.
   Total charges used to assess long-term customer value.
   Helps identify high-value customers at risk of churn.

Service Engagement Features
   Customer service adoption was evaluated:
   Presence of support/security services (Tech Support, Online Security, Backup, etc.).
   Streaming and add-on service usage as engagement signals.
   Higher service adoption often correlates with lower churn.

Payment Behaviour Indicators
   Payment method characteristics were analysed:
   Automatic payments vs manual payment methods.
   Electronic check usage often indicates lower engagement.
   Helps identify customers with potential payment friction.

Outcome of Feature Engineering
   Feature engineering helped:
   Identify behavioural drivers of churn.
   Improve customer segmentation.
   Highlight high-risk customer groups.
   Support more effective retention strategies.
These engineered features enhance the analytical depth of churn analysis and prepare the dataset for predictive modelling or advanced business insights.

Step 5 — Churn Modelling With R 
The cleaned dataset prepared in MySQL was exported as a CSV file and imported into R for predictive churn modelling. Initial checks were performed to validate data structure, variable types, and target variable consistency before model training.
A logistic regression model was built in R to predict customer churn using tenure, monthly charges, total charges, and contract type. The model provided interpretable insights into key churn drivers and enabled probability-based churn prediction.
Model Development
The dataset was prepared by:
    Converting the churn variable into a categorical factor.
    Removing irrelevant identifiers such as customer ID.
    Handling missing values before modelling.
    Splitting the dataset into training (70%) and testing (30%) sets.
    A logistic regression model was trained using key predictive features including:
    Customer tenure
    Monthly charges
    Total charges
    Contract type
This model estimates the probability of customer churn.

Model Evaluation

    Model performance was assessed using standard classification metrics:
    Confusion Matrix: Evaluated correct vs incorrect churn predictions.
    Precision & Recall: Assessed model effectiveness in identifying churned customers.
    ROC Curve & AUC Score: Measured overall model discrimination ability.
    The model achieved an evaluation score of approximately 0.82, indicating good predictive performance and strong ability to distinguish churned customers from retained ones.
    
Key Insights from Modelling
The modelling results indicated:
    Customers on month-to-month contracts showed higher churn probability.
    Shorter tenure customers were more likely to churn.
    Higher monthly charges contributed to increased churn risk.
    Contract commitment and service engagement played important roles in retention.
    
    
Step 6 — Postdictive Analysis
Postdictive analysis was conducted to evaluate how well the churn prediction model performed by comparing predicted churn outcomes with actual customer churn behaviour. This step helps assess model reliability and identify areas for improvement.

 Predicted vs Actual Churn Comparison
A confusion matrix was used to compare model predictions with actual churn outcomes. This enabled evaluation of:
   Correct churn predictions (True Positives)
   Correct retention predictions (True Negatives)
   Incorrect churn predictions (False Positives)
   Missed churn cases (False Negatives)
The model achieved an overall performance score of approximately 0.82, indicating good predictive capability.

Where the Model Performed Well
The model showed strong performance in:
    Identifying customers on month-to-month contracts, who typically have higher churn risk.
    Predicting churn among customers with short tenure, reflecting early lifecycle churn patterns.
    Detecting churn risk among customers with higher monthly charges, suggesting pricing sensitivity.
    These findings align with industry churn trends, supporting the model’s validity.

Where the Model Struggled
Some prediction limitations were observed:

    Customers with moderate tenure but high engagement were occasionally misclassified.
    Certain churn cases driven by external factors (e.g., service experience, competition) may not be captured in the dataset.
    Behavioural variables not included in the dataset may affect prediction accuracy.
    Such misclassifications are expected in real-world churn modelling.

Insights from Postdictive Analysis
The evaluation suggests:

    The model provides reliable churn risk identification.
    Additional behavioural or customer experience data could improve accuracy.
    Combining predictive modelling with business insights strengthens retention strategies.


Step 7 — Business Recommendations
Based on exploratory analysis, feature engineering, and churn prediction modelling, several actionable business recommendations were identified to help reduce customer churn and improve retention.
	Prioritise Month-to-Month Customers
Highest churn risk segment.
Offer incentives for longer contracts and bundled plans.
	Improve Early Customer Retention
Short-tenure customers churn more frequently.
Strengthen onboarding and early engagement support.
	Review Pricing Strategy
Higher monthly charges correlate with increased churn.
Consider flexible pricing, loyalty discounts, or value-added benefits.
	Increase Service Engagement
Customers using support and add-on services show lower churn.
Promote bundled services and proactive support.
	Focus on High-Value Customers at Risk
Retaining high-spend customers protects recurring revenue.
Provide targeted retention offers and personalised support.


