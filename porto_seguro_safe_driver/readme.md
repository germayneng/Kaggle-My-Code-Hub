Model 1: 

$ python3 preprocessing.py 
<br>
$ Rscript feature_engineering.R
<br>
$ python3 lgbm_cv_folds.py / $ python3 lgbm_cv.py 
<br>
$ python3 lgbm_submission.pt
# Model 1 


benchmark to beat: 0.28825969783038985 |  0.281 

Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
 X | ohe  |  0.2887805390415061 |  0.281   |  ? |  X 
 X | en11,11 + en6, 06  |  0.28825969783038985 |  0.281  |  ? |  X 


# Model 2 


benchmark to beat: 0.2907152600232563  | 0.282(best) ( KF) 


## SKF 



Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
xgb | add us |  0.29153705495951765  |    | ?  | Y
xgb | ohe |  0.2920562162020719  | 0.282   | ?  | Y


## KF 

Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
xgb | ohe |  0.2907152600232563  | 0.282(best)   | 0.008  | Y
xgb | lce ind 05 cat |  0.2891376153868709  |    | ?  | X
xgb | en4, 04 |  0.28994119365130144   |  0.282  | ?  | Y
xgb | en1, 01 | 0.28905027132813627   |  0.282  | ?  |  Y
xgb | en6, o6 | 0.28774070939103197  | 0.282   |  0.005 |  Y
xgb | en11, ocar11 | 0.28689584177200333  |  0.282  | 0.004895841772  |  Y
xgb | en11 seed vary | 0.2873501489301373   |  X  | X  |  X
xgb | en11 | 0.28651896266258636   | 0.282   | 0.0045189626625  |  X
xgb | en11, encar14  | 0.29387663437974354  | 0.28   | 0.0138766343797  |  X
xgb | en11, encar14, ocar11, ocar14  | 0.2956987984323126  | 0.279   | 0.0166987984323126  |  X
 |  |   |    |   |  


# Model 3 

?


Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
 |  |   |    |   |  
