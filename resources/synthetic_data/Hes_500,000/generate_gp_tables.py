import random
import pandas as pd
import numpy as np

# Number of unique ids
length = 500000
eid = list(range(length))

# Create a range of dates to take from
min_d = pd.to_datetime('01/01/2000')
max_d = pd.to_datetime('31/12/2020')
d = (max_d - min_d).days + 1

# GP_clinical file
# Create random number of indexes for each person with id
gp_clin_temp = []
for i in eid:
    x = random.randint(1, 11)
    for j in range(x):
        gp_clin_temp.append([i])

# Create the main hospital data (gp_clinical)
gp_clin = pd.DataFrame(gp_clin_temp, columns=['eid'])
n_clin = len(gp_clin)
print(f'length of gp_clinical: {n_clin}')

# Add columns we use in the transformation with randomised values (gp_clinincal)
gp_clin['event_dt'] = (min_d + pd.to_timedelta(np.random.randint(d, size=n_clin), unit='d')).strftime("%d/%m/%Y")

# Add to the unused the most frequent value from the scan report (gp_clinical)
gp_clin['code_type'] = 0
gp_clin['code'] = '42L..'
gp_clin['value'] = 9.1000004

# GP_scipts file
# Create random number of indexes for each person with id
gp_scr_temp = []
for i in eid:
    x = random.randint(1, 11)
    for j in range(x):
        gp_scr_temp.append([i])

# Create the main hospital data (gp_scripts)
gp_scr = pd.DataFrame(gp_scr_temp, columns=['eid'])
n_scr = len(gp_scr)
print(f'length of gp_scripts: {n_scr}')

# Add columns we use in the transformation with randomised values (gp_scripts)
gp_scr['issue_date'] = (min_d + pd.to_timedelta(np.random.randint(d, size=n_scr), unit='d')).strftime("%d/%m/%Y")

# Add to the unused the most frequent value from the scan report (gp_scripts)
gp_scr['dmd_code'] = 321177003

# Write to csv
gp_clin.to_csv('covid19_tpp_gp_clinical.csv', sep=',', index=False)
gp_scr.to_csv('covid19_tpp_gp_scripts.csv', sep=',', index=False)
