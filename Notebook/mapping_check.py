import pandas as pd

df = pd.read_csv(r"G:\My Drive\DATA Analysis\UCI Machine Learning Repository\diabetic_data_validated.csv")

from scripts.convert_diag_1 import categorize_diagnois

df["diag_1_category"] = df["diag_1"].apply(categorize_diagnois)

print("diag_1_category")


# Verifying the each mapping

diagnosis_mapping_check = (
    df[
        ["diag_1", "diag_1_category"]
    ]
    .drop_duplicates()
    .sort_values(
        by=["diag_1_category", "diag_1"]
    )
)

print(diagnosis_mapping_check)

# Saving the mapping for review in .CSV file name: diag_1_category_mapping

diagnosis_mapping_check.to_csv(
    "diag_1_category_mapping.csv",
    index=False
)