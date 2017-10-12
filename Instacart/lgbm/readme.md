
Base script from sh1ng: https://github.com/sh1ng/imba



LGBM model with adjustments, new features and optimized hyperparameters

$ python3 create_products.py
$ python3 split_data_set.py
$ python3 orders_comsum.py
$ python3 user_product_rank.py
$ python3 create_prod2vec_dataset.py
$ python3 skip_gram_train.py
$ python3 skip_gram_get.py
$ python3 lgbm_cv.py # optional...
$ python3 lgbm_submition.py # prediction with lgbm
** Use f1_maximization.R on generated submission_lgbm.csv 
