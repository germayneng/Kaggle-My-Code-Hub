Model 1: score 0.28X

$ python3 preprocessing.py 
<br>
$ Rscript feature_engineering.R
<br>
$ python3 lgbm.py 

# Model 1 



Pretty consistent cv for both. 

Model | des| cv | LB |  
--- | --- | --- | --- 
LGBM | added loo | 0.3? | 0.265 ?????
LGBM | feature selection |  0.2840037745259099 | 0.278
LGBM | normal prep | 0.28388587 | 0.278
LGBM | ohe on 8 cat |  0.2834999 | 0.277
LGBM | LOO on 1618, 0609 | 0.28337639620598 | 0.276

