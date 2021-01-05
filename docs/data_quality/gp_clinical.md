The original data for GP clinical contain 2600 unique Read codes for which both `value1` and `value2` may be both filled for the same record. 
Even by applying strict prioritization rules, we are still faced with hundreds of codes requiring some sort of deeper investigation and custom logic 
(e.g. 227 codes by setting a frequency cutoff of 500 for being observed in both value fields, 165 codes if setting it to 1000).

The default ETL behaviour is to take whichever value field is available first and ignore the other,
so if both `value1` and `value2` are filled, `value1` is used by default.

At the moment, we have implemented logic that explicitly handles `value1` and `value2` simultaneously
only for 3 Read codes related to blood pressure, according to [these rules](https://github.com/spiros/ukb-biomarker-phenotypes#SBP)). 
I examined more closely the counts for these blood pressure codes to see if our custom logic works as expected;
the picture below shows what we are handling correctly (green) and what is not missed by the current implementation (red): 

<img width="839" alt="Screenshot 2020-12-21 at 11 55 42" src="https://user-images.githubusercontent.com/32969540/102774576-8d980f00-438b-11eb-86cd-7be7b5644c76.png">

If we establish a universal threshold for ignoring counts in unexpected fields (for example, a cutoff of 1000 occurrences per field), 
we would be able to ignore every red box except for code `2469.`, provider `2` and `4`, value column `value2`. 
For provider `2`, this is a significant problem: our logic is completely ignoring `value2`, 
and given the little overlap with `value1` (~120 rows), it means we are missing > 180'000 values.
