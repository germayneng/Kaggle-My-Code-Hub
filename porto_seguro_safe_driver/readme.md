Model 1: 

$ python3 preprocessing.py 
<br>
$ Rscript feature_engineering.R
<br>
$ python3 lgbm_cv_folds.py / $ python3 lgbm_cv.py 
<br>
$ python3 lgbm_submission.pt
# Model 1 

## Stratified 

## RE-work 
Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
LGBM | edit some preprocess | 0.28693208414804006  | low 0.278 |  | compare with ind12
LGBM | re-added cat 11 |  0.2871075115416951 | low 0.278 |  | compare with ind12
LGBM | remove ind 12 bin | 0.28629249306268223 | 0.278 | 0.008 | baseline2 

## Deprecated
Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
LGBM | added neg function | 0.2865639445401815  | 0.278  |   | 
LGBM | added interaction term | 0.2862096393150962 | 0.277 | 0.009  | N
LGBM | remove ind 12 bin | 0.28677517691685267 | 0.278 | 0.008 | Y 
LGBM | remove muni original and impact original |  0.2866260257361032 | 0.278 | 0.008 | Y
LGBM | remove impact original | 0.2853545955971464  | 0.278 | 0.008 | Y 
LGBM | added impact | 0.2877287356566279  | 0.277 | 0.01 | Y
LGBM | added loo | 0.3? | 0.265 ????? | 0.035 | N
LGBM | feature selection |  0.2840037745259099 | 0.278 | 0.006 | Y
LGBM | normal prep | 0.28388587 | 0.278 | 0.005 | Y
LGBM | ohe on 8 cat |  0.2834999 | 0.277 | X | N
LGBM | LOO on 1618, 0609 | 0.28337639620598 | 0.276 | X | N 


# Model 2 

## F fold 

Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
xgb | baseline2_1050  |   |   |   | 
xgb | baseline2_814  | 0.2873501489301373  | 0.279   |   |  
