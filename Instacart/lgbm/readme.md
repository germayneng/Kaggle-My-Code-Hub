
Base script from sh1ng: https://github.com/sh1ng/imba



LGBM model with adjustments, new features and optimized hyperparameters

$ python3 create_products.py
<br>
$ python3 split_data_set.py
<br>
$ python3 orders_comsum.py
<br>
$ python3 user_product_rank.py
<br>
$ python3 create_prod2vec_dataset.py
<br>
$ python3 skip_gram_train.py
<br>
$ python3 skip_gram_get.py
<br>
$ python3 lgbm_cv.py # optional...
<br>
$ python3 lgbm_submition.py # prediction with lgbm
<br>
** Use f1_maximization.R on generated submission_lgbm.csv**

```R
submission <- all_prob %>%
  group_by(order_id) %>%
  summarise(products = exact_F1_max_none(new2, product_id))


write.csv(submission, file = "final_final_final.csv", row.names = F)

```
