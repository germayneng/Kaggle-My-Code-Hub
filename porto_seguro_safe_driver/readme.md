Model 1: score 0.28X

$ python3 preprocessing.py 
<br>
$ Rscript feature_engineering.R
<br>
$ python3 lgbm.py 

# Model 1 



Pretty consistent cv for both. 

Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
X | remove ind 12 bin | 
LGBM | remove muni original and impact original |  0.2866260257361032 | 0.278 | 0.008 | Y
LGBM | remove impact original | 0.2853545955971464  | 0.278 | 0.008 | Y 
LGBM | added impact | 0.2877287356566279  | 0.277 | 0.01 | Y
LGBM | added loo | 0.3? | 0.265 ????? | 0.035 | N
LGBM | feature selection |  0.2840037745259099 | 0.278 | 0.006 | Y
LGBM | normal prep | 0.28388587 | 0.278 | 0.005 | Y
LGBM | ohe on 8 cat |  0.2834999 | 0.277 | X | N
LGBM | LOO on 1618, 0609 | 0.28337639620598 | 0.276 | X | N 

