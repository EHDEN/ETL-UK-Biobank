import random
import pandas as pd
import numpy as np

# Number of unique ids
length = 7919
eid = list(range(length))

# Create a range of dates to take from
min_d = pd.to_datetime('01/01/2000')
max_d = pd.to_datetime('31/12/2020')
d = (max_d - min_d).days + 1

# HESIN file
# Create random number of indexes for each person with id+index unique
hes_temp = []
for i in eid:
    x = random.randint(1, 137)
    for j in range(x):
        hes_temp.append([i, j])

# Create the main hospital data (hesin)
hesin = pd.DataFrame(hes_temp, columns=['eid', 'ins_index'])
n_hes = len(hesin)
print(f'length of main hes: {n_hes}')

# Add columns we use in the transformation with randomised values (hesin)
hesin['dsource'] = np.random.choice(['HES', 'SMR', 'PEDW'], size=n_hes)
hesin['epistart'] = (min_d + pd.to_timedelta(np.random.randint(d, size=n_hes), unit='d')).strftime("%d/%m/%Y")
hesin['epiend'] = (min_d + pd.to_timedelta(np.random.randint(d, size=n_hes), unit='d')).strftime("%d/%m/%Y")
hesin['spell_index'] = np.random.choice(range(1, 967), size=n_hes)
hesin['elecdate'] = '18/02/2010'
hesin['admidate'] = (min_d + pd.to_timedelta(np.random.randint(d, size=n_hes), unit='d')).strftime("%d/%m/%Y")
hesin['admimeth'] = np.random.choice(range(1, 101), size=n_hes)
hesin['admisorc'] = np.random.choice(range(1, 101), size=n_hes)
hesin['disdate'] = (min_d + pd.to_timedelta(np.random.randint(d, size=n_hes), unit='d')).strftime("%d/%m/%Y")
hesin['disdest'] = np.random.choice(range(1, 101), size=n_hes)

# Add to the unused the most frequent value from the scan report (hesin)
hesin['source'] = 6
hesin['epidur'] = 0
hesin['bedyear'] = 0
hesin['epistat'] = 3
hesin['epitype'] = 1
hesin['epiorder'] = 1
hesin['spell_seq'] = 0
hesin['spelbgin'] = 2
hesin['spelend'] = 'Y'
hesin['speldur'] = 0
hesin['pctcode'] = '5N1'
hesin['gpprpct'] = '5N1'
hesin['category'] = 10
hesin['elecdur'] = 1
hesin['admimeth_uni'] = 1001
hesin['admisorc_uni'] = 1000
hesin['firstreg'] = 8
hesin['classpat_uni'] = 1000
hesin['classpat'] = 2
hesin['intmanag_uni'] = 200
hesin['intmanag'] = 2
hesin['mainspef_uni'] = 1350
hesin['mainspef'] = 100
hesin['tretspef_uni'] = 1490
hesin['tretspef'] = 300
hesin['operstat'] = 1
hesin['dismeth_uni'] = 1000
hesin['dismeth'] = 1
hesin['disdest_uni'] = 1000
hesin['carersi'] = 99

# HESIN_DIAG
# Create random number of indexes for each person with id+index unique
diag_temp = []
for i in eid:
    x = random.randint(1, 197)
    for j in range(x):
        diag_temp.append([i, j])

# Create the diagnosis data (hesin_diag)
hesin_diag = pd.DataFrame(diag_temp, columns=['eid', 'ins_index'])
n_diag = len(hesin_diag)
print(f'length of hes_diagnosis: {n_diag}')

# Add columns we use in the transformation with randomised values (hesin_diag)
hesin_diag['level'] = np.random.choice(range(1, 3), size=n_diag)
hesin_diag['diag_icd9'] = np.random.choice(['V252', '6262', '78909', '4549', '7890', '7865',
                                            '6359', '4556', '1749', '5509', '5742', '6117',
                                            '6289'], size=n_diag)
hesin_diag['diag_icd10'] = np.random.choice(['I10', 'E119', 'Z864', 'E780', 'J459', 'Z511',
                                             'Z867', 'Z921', 'E039', 'I209', 'I48', 'I259',
                                             'C509'], size=n_diag)

# Add to the unused the most frequent value from the scan report (hesin_diag)
hesin_diag['arr_index'] = 0
hesin_diag['diag_icd9_nb'] = None
hesin_diag['diag_icd10_nb'] = 2

# HESIN_OPER
# Create random number of indexes for each person with id+index unique
oper_temp = []
for i in eid:
    x = random.randint(1, 163)
    for j in range(x):
        oper_temp.append([i, j])

# Create the diagnosis data (hesin_diag)
hesin_oper = pd.DataFrame(oper_temp, columns=['eid', 'ins_index'])
n_oper = len(oper_temp)
print(f'length of hes_operations: {n_oper}')

# Add columns we use in the transformation with randomised values (hesin_oper)
hesin_oper['level'] = np.random.choice(range(1, 2), size=n_oper)
hesin_oper['opdate'] = (min_d + pd.to_timedelta(np.random.randint(d, size=n_oper), unit='d')).strftime("%d/%m/%Y")
hesin_oper['oper3'] = np.random.choice([704, 687, 4011, 387, 6961, 6512, 3811,
                                        608, 7421, 913, 979], size=n_oper)
hesin_oper['oper4'] = np.random.choice(['X998', 'Z942', 'Z943', 'G451', 'X403', 'Y981', 'H229',
                                        'C751', 'C712', 'Y534', 'Z274'], size=n_oper)

# Add to the unused the most frequent value from the scan report (hesin_oper)
hesin_oper['arr_index'] = 0
hesin_oper['oper3_nb'] = None
hesin_oper['oper4_nb'] = None
hesin_oper['posopdur'] = 0
hesin_oper['preopdur'] = 0

# Write to csv
hesin.to_csv('hesin.csv', sep=',', index=False)
hesin_diag.to_csv('hesin_diag.csv', sep=',', index=False)
hesin_oper.to_csv('hesin_oper.csv', sep=',', index=False)
