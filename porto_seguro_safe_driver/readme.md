Model 1: 

$ python3 preprocessing.py 
<br>
$ Rscript feature_engineering.R
<br>
$ python3 lgbm_cv_folds.py / $ python3 lgbm_cv.py 
<br>
$ python3 lgbm_submission.pt
# Model 1 

## K fold 


Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---



# Model 2 


Model | des| cv | LB |  delta | implemented? 
--- | --- | --- | --- | --- | ---
xgb | encar11 | ?  | ?   | ?  |  X
xgb | encar11, encar14  | 0.29387663437974354  | 0.28   |   |  X
xgb | encar11, encar14, ocar11, ocar14  | 0.2956987984323126  | 0.279   | 0.0166987984323126  |  X
xgb | ? | ?  | ?   | ?  |  X


