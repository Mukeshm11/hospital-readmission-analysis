import pandas as pd
import numpy as np
df = pd.read_csv(r"G:\My Drive\DATA Analysis\UCI Machine Learning Repository\diabetic_data_validated.csv")

def categorize_diagnois(code): # here we are defining the function categorize_diagnosis
    # Handle missing values
    if pd.isna(code):
        return 'Missing/Unknown'
    # converting values into clean text
    code = str(code).strip().upper()

    # Handle text based missing values
    if code in ["","?","LEAVE THIS BLANK","NA","NONE","N/A"]:
        return "Missing/Unknown"

    # V-codes and E-codes do not fit the selected categories
    if code.startswith("V") or code.startswith("E"):
        return "Other"

    # convert numneric ICD-9 code to a number
    try:
        numeric_code = float(code)
    except ValueError:
        return "Missing/Unknown"

    # Diabetes must be checked specifically as in between 250 to 251 it is in point means float
    if 250 <= numeric_code <= 251:
        return "Diabetes"

    elif 140 <= numeric_code <= 239:
        return "Neoplasms"

    elif 390 <= numeric_code <= 459:
        return "Circulatory"

    elif 460 <= numeric_code <= 519:
        return "Respiratory"

    elif 520 <= numeric_code <= 579:
        return "Digestive"

    elif 580 <= numeric_code <= 629:
        return "Genitourinary"

    elif 710 <= numeric_code <= 739:
        return "Musculoskeletal"

    elif 800 <= numeric_code <= 999:
        return "Injury"

    else:
        return "Other"


# Apply the function to the diag_1 column
df["diag_1_category"] = df["diag_1"].apply(categorize_diagnois)

# Review the result
print(df[["diag_1", "diag_1_category"]].head(20))

# Export the complete updated dataset
output_path = r"G:\My Drive\DATA Analysis\UCI Machine Learning Repository\diabetic_data_with_diagnosis_category.csv"

df.to_csv(output_path, index=False)

print("CSV exported successfully:")
print(output_path)