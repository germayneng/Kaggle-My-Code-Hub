#' ================================
#' =======kaggle: walmart =========
#' 
#' example code based on store 1- department 1. 
#' forecasting 39 weeks ahead. Total data set 143 weeks. From 2010 Feb to Oct 2012 weekly data
#' ================================
# to do: UCM 
# https://cran.r-project.org/web/packages/rucm/vignettes/rucm_vignettes.html



library(data.table)
library(forecast)
library(ggplot2)



train <- fread('train_sample.csv')
train <- data.frame(train)
store.weekly <- ts(train$Weekly_Sales,frequency=365.25/7, start = 2010 + 31/365.25)

#' ================================
#' ==========STLF =================
#' ETS modelling 
#' Arima 
#' Naive
#' ================================


ets.model <- stlf(store.weekly,method="ets",h=39)
autoplot(ets.model, series = 'ets')
autoplot(ets.model.mean, series = 'ets')


arima.model <- stlf(store.weekly, method = 'arima', h=39, stepwise = FALSE, approx = FALSE)


naive.model <- stlf(store.weekly, method = 'naive', h=39)


#' ================================
#' =======TBATS modelling ========= 
#' state space model 
#'================================

train.bats <- tbats(store.weekly)
tbats.forecast <- forecast(train.bats, h = 39)
autoplot(tbats.forecast, series = 'tbats')


#' ================================
#'  Fourier terms - regression with arima errors 
#' ================================

bestfit <- list(aicc=Inf)
count <- 0 


#' set count to capture how many iteration of optimal k (lowest aicc)
#' max i 25. 

for(i in 1:25)
{
  fit <- auto.arima(store.weekly, xreg=fourier(store.weekly, K=i),seasonal = FALSE)
  if(fit$aicc < bestfit$aicc) {
    bestfit <- fit 
    count = count + 1}
  else break;
}

fourier.fcast <- forecast(bestfit, xreg=fourier(gas, K=1, h=39))
autoplot(fourier.fcast)


#' ================================
#' ==========Neural nets=========== 
#' ================================


nnet.model <- store.weekly %>% nnetar() 
nnet.fcast <- forecast(nnet.model, h=39)


#' ================================
#' ===============plots============ 
#' ================================

# comparing the plots 

autoplot(fourier.fcast$mean, series = 'fourier') +
autolayer(tbats.forecast$mean, series = 'tbats') + 
autolayer(ets.model$mean, series = 'ets') + 
autolayer(arima.model$mean, series = 'arima') + 
autolayer(naive.model$mean, series = 'naive') +
autolayer(nnet.fcast$mean, series = 'nnet')



#' comments: the regression with arima errors using fourier terms is bad. Based on Ljung, there is 
#' autocorrelation. Similar, tbats and also ets using stlf also have autocorrelation based on Ljung
#' 
#' The other models looks very good. We can do an average





#' ================================
#' ==========References============ 
#' ================================

# Srihari
https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8023#43811
https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8055#44044
https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8095#44279

# champ David thaler 
https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8028#65096
# 
http://ideone.com/pUw773

