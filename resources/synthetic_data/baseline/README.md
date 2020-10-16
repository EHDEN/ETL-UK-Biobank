The source tables in this folder were generate using `tofu` (https://github.com/spiros/tofu).

The input codes used for each table are found in the folder `tofu_input_codes`;
at the moment you would have to pass these manually to `tofu` using the `--field` flag,
but we could implement a new version taking a file directly as input (and save some typing).

Example `tofu` run:
```bash
python tofu.py -n 100 --field 31 34 52 21000 54 -o baseline_to_patient.csv
```