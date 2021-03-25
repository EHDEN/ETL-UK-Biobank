import pandas as pd

# NOTE!
# Note that the comments will be appended. If you run the script twice, they’ll be duplicated.

# Read DQD Field Level table
DQD_file = "src/dqd_achilles/DQD_Field_Level_v5.3.1_UKB.csv"
df_DQD = pd.read_csv(DQD_file)

# Read changes file
df_changes = pd.read_csv("src/dqd_achilles/edit_DQD_Field_Level/thresholds_to_edit.csv", header=4)

# Go over each row, which indicate each alteration
for index, row in df_changes.iterrows():

    # Subset row
    col_check = row['Name']

    if col_check == 'fkDomain':
        selection = df_DQD.index[
            (df_DQD['cdmTableName']==row['Table']) & \
            (df_DQD['cdmFieldName']==row['Field'].lower()) & \
            (df_DQD[col_check]==row['Third_Variable'].capitalize())].tolist()
    else:
        selection = df_DQD.index[
            (df_DQD['cdmTableName']==row['Table']) & \
            (df_DQD['cdmFieldName']==row['Field'].lower())].tolist()

    # only one row edited
    if len(selection) != 1:
        continue

    # Edit threshold
    df_DQD.loc[selection, f"{col_check}Threshold"] = int(float(row['New_Threshold'].strip('%')))

    # Edit Notes
    note = f"{row['Date_Of_DQD_Execution']} | {row['`% Rows Violated`']} | {row['Comment']}"
    if pd.isna(df_DQD.loc[selection,f"{col_check}Notes"]).tolist():
        df_DQD.loc[selection,f"{col_check}Notes"] = note
    else:
        df_DQD.loc[selection,f"{col_check}Notes"] = f"{df_DQD.loc[selection,(col_check+'Notes')]} \n {note}"
# save
df_DQD.to_csv(DQD_file, index=False)