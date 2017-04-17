# Kaggle-Walmart_Store_Sales_Forecasting

Competition Details:
* https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting


---

## Solutions
The walmart data set is a weekly dataset that captures the store sales. Most participants did the forecasting without using the additional features. A general idea is to create various models and perform ensemble learning. 

For my solution, I make use of a particular department of a store, i.e store 1 - department 10. For this competition, you will have to isolate each store-department, model the forecast, then combine them back to a dataframe. Since this is for learning purposes, I will only work on store1-department 10: consisting of 143 weekly data points. 

As mentioned above, it will make more sense to use different models to do the forecasting. Here are the models used: 

* ETS function 
* Arima 
* Naive 
* Neural Networks
* Xgboost 

Here is the chart plot of the ensemble of models: 
![example_ensemble](https://cloud.githubusercontent.com/assets/22788747/25085263/cebe3016-2393-11e7-80bf-c5482a41687c.png)






---

# References 

* https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8125

* https://github.com/davidthaler/Walmart_competition_code

* Ensemble Learning
  + http://ellisp.github.io/blog/2016/11/06/forecastxgb
  + https://www.r-bloggers.com/an-intro-to-ensemble-learning-in-r/
  + http://machinelearningmastery.com/machine-learning-ensembles-with-r/
