import pandas as pd

# NOTE!
# Note that the comments will be appended. If you run the script twice, they’ll be duplicated.

# Read DQD Field Level table
DQD_file = "src/dqd_achilles/DQD_Field_Level_v5.3.1_UKB.csv"
df_DQD = pd.read_csv(DQD_file)

# Read changes file
df_changes = pd.read_csv("src/dqd_achilles/edit_DQD_Field_Level/thresholds_to_edit.csv", header=0)

# Go over each row, which indicate each alteration
for index, row in df_changes.iterrows():

    # Name of check
    col_check = row['Check']

    # Subset row
    selection = df_DQD.index[
        (df_DQD['cdmTableName'].str.lower() == row['Table_name'].lower()) & \
        (df_DQD['cdmFieldName'].str.lower() == row['Field_name'].lower())]  \
        .tolist()

    # Check only one row edited
    if len(selection) != 1:
        continue

    # Edit <...>Threshold
    df_DQD.loc[selection, f"{col_check}Threshold"] = \
        int(float(row['New_Threshold'].strip('%')))

    # Edit <...>Notes
    note = f"{row['Date_Of_DQD_Execution']} | {row['%_Rows_violated']} | {row['Comment']}"
    if pd.isna(df_DQD.loc[selection,f"{col_check}Notes"]).tolist():
        df_DQD.loc[selection,f"{col_check}Notes"] = note
    else:
        df_DQD.loc[selection,f"{col_check}Notes"] = f"{df_DQD.loc[selection,(col_check+'Notes')]} \n {note}"
# Save
df_DQD.to_csv(DQD_file, index=False)