# Insights and Recommendations
### 1. Thirty-day readmissions represent a minority of encounters
Of the 101,766 hospital encounters analyzed, 11,357 resulted in readmission within 30 days, giving an overall rate of 11.16%.

Recommendation: Use this rate as the dataset baseline when comparing age, diagnosis, and previous-utilization groups. Include encounter counts alongside rates to avoid misleading conclusions from small groups.

### 2. Most encounters involved 11–20 medications
The 11–20 medication group accounted for 52,025 encounters (51.12%). Only 5,237 encounters (5.15%) involved 31 or more medications.

#### Recommendation: 
Use medication groups of 1–10, 11–20, 21–30, and 31+ for reporting. Retain the original numeric values for modeling. Medication frequency alone does not establish a relationship with readmission.

### 3. High accuracy concealed weak readmission detection
The initial Logistic Regression model achieved 89.29% accuracy, but identified only 18 of 2,151 actual readmissions in the test set. Recall was 0.84%, demonstrating that accuracy alone was insufficient for evaluating this imbalanced target.

#### Recommendation: 
Evaluate models using precision, recall, F1-score, ROC-AUC, and Average Precision, rather than selecting a model based only on accuracy.

### 4. The revised Random Forest improved recall but generated more false positives
The revised Random Forest achieved 56.81% recall, 16.34% precision, and an F1-score of 25.38%. It detected more actual readmissions, but most positive predictions were false positives.

#### Recommendation: 
Compare prediction thresholds on validation data and assess the trade-off between missed readmissions and false alerts. Treat the model as an exploratory portfolio prototype, not a clinically validated decision tool.

#### Limitations
These findings describe historical encounters and observed associations, not causal relationships. Model probabilities and risk groups require further validation before operational use.

For supporting analysis and limitations, see the[Detailed Insights and Recommendations Report](reports/Insights_and_Recommendations.md)