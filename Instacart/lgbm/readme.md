
Base script released from sh1ng: https://github.com/sh1ng/imba
<br>
Big drama and anger: https://www.kaggle.com/c/instacart-market-basket-analysis/discussion/37697#211098

<br>

I was initially very angry as it distorted the entire leaderboard. Nevertheless, I have to adapt. The entire kaggle adapted. It was still an intensive competition. As such, when he released his script (0.40299, a top 2% score, a week earlier) >>>>> when competition ends (0.4031115, bronze last postition at 10% )

<br>

# How to use?

LGBM model with adjustments, new features and optimized hyperparameters

* create a folder call: data with all the raw data. Download the train and test sets from kaggle. 
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
$ python3 order_streaks.py
<br>
$ python3 lgbm_submition.py 
<br>
** Use f1_maximization.R on generated submission_lgbm.csv**

```R
submission <- lgbm_submission %>%
  group_by(order_id) %>%
  summarise(products = exact_F1_max_none(new2, product_id))


write.csv(submission, file = "final_submission.csv", row.names = F)

```
