# Kaggle Competition: Walmart Sales Forecasting 

Competition Details:
* https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting


---

## Summary
In this competition, most of the participants did not use any other features provided, and instead only work with the time series sales outcome. In my code in example2.R script, you will realize that I work only on 1 particular department and store. (sample dataset) Main reason is that I want to get the general feel for various model performance as well as average ensemble learning performance. For the kaggle train set, it will consist of multiple store with multiple department. You will have to isolate them and do a model fit since each store-department will be forecasted using a different model. 

For my solution, I make use of a particular department of a store, i.e store 1 - department 10. For this competition, you will have to isolate each store-department, model the forecast, then combine them back to a dataframe. Since this is for learning purposes, I will only work on store1-department 10: consisting of 143 weekly data points. 

As mentioned above, it will make more sense to use different models to do the forecasting. Here are the models used: 

* ETS function 
* Arima 
* Naive 
* Neural Networks
* Xgboost 

Here is the chart plot of the ensemble of models: 
![example_ensemble](https://cloud.githubusercontent.com/assets/22788747/25085263/cebe3016-2393-11e7-80bf-c5482a41687c.png)

Interestingly, naive performs extremely well on its own. Other good performer is the ensemble of ETS,ARIMA.Naive and xgboost. Neural network is indeed disappointing. One point to note that in other for me to evaluate ensemble learning, I have to take roughly 94% of trainset to model and test against the remaining 6% as test set. This is because ets function is returning different order (ANN) instead of AAN when using 100% of the data.  

Although naive is pretty good, but I will prefer the 4 combined model for the actual forecasting. :) 


---

# References 

* https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8125

* https://github.com/davidthaler/Walmart_competition_code

* Ensemble Learning
  + http://ellisp.github.io/blog/2016/11/06/forecastxgb
  + https://www.r-bloggers.com/an-intro-to-ensemble-learning-in-r/
  + http://machinelearningmastery.com/machine-learning-ensembles-with-r/
