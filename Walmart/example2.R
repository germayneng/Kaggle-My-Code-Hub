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
library(plotly)
library(forecastxgb) # still on trial, unstable 

the.data <- fread('train_sample.csv')
the.data <- data.frame(the.data)
store.weekly.overall <- ts(the.data$Weekly_Sales,frequency=365.25/7, start = 2010 + 31/365.25)
# split for train and test 
store.weekly <- window(store.weekly.overall, end = 2012 + 242/365.25)
store.weekly.test <- window(store.weekly.overall, start = 2012.66)




#' ================================
#' ==========STLF =================
#' ETS modelling 
#' Arima 
#' Naive
#' ================================


ets.model <- stlf(store.weekly,method="ets",h=8)


arima.model <- stlf(store.weekly, method = 'arima', h=8, stepwise = FALSE, approx = FALSE)


naive.model <- stlf(store.weekly, method = 'naive', h=8)


#' ================================
#' =======TBATS modelling ========= 
#' state space model 
#'================================

train.bats <- tbats(store.weekly)
tbats.forecast <- forecast(train.bats, h = 8)
autoplot(tbats.forecast, series = 'tbats')


#' ================================
#'  Fourier terms - regression with arima errors 
#' ================================

bestfit <- list(aicc=Inf)
count <- 0 


#' set count to capture how many iteration of optimal k (lowest aicc)
#' max i 25. 
#' we set seasonal = false probably due to having the fourier term to handle seasonality

for(i in 1:25)
{
  fit <- auto.arima(store.weekly, xreg=fourier(store.weekly, K=i),seasonal = FALSE)
  if(fit$aicc < bestfit$aicc) {
    bestfit <- fit 
    count = count + 1}
  else break;
}

fourier.fcast <- forecast(bestfit, xreg=fourier(store.weekly, K=1, h=8))
autoplot(fourier.fcast)


#' ================================
#' ==========Neural nets=========== 
#' ================================


nnet.model <- store.weekly %>% nnetar() 
nnet.fcast <- forecast(nnet.model, h=8)




#' ================================
#' =====Xgboost autoregression===== 
#' ================================
#' https://github.com/ellisp/forecastxgb-r-package


model <- xgbar(store.weekly) # data is stationary, no need for trend differencing   
fcast.xgb <- forecast(model, h=8) 








#' ================================
#' ===============plots============ 
#' ================================

# comparing the plots 

autoplot(fourier.fcast$mean, series = 'fourier') +
autolayer(tbats.forecast$mean, series = 'tbats') + 
autolayer(ets.model$mean, series = 'ets') + 
autolayer(arima.model$mean, series = 'arima') + 
autolayer(naive.model$mean, series = 'naive') +
autolayer(nnet.fcast$mean, series = 'nnet') +
autolayer(fcast.xgb$mean, series = 'xgboost')


#' comments: the regression with arima errors using fourier terms is bad. Based on Ljung, there is 
#' autocorrelation. Similar, tbats and also ets using stlf also have autocorrelation based on Ljung
#' 
#' The other models looks very good. We can do an average



#' ================================
#' ============Ensemble============ 
#' ================================
#' 
#' 
#' 
#' 1 : ets
#' 2 : arima
#' 3 : naive 
#' 4 : nnet
#' 5 : xgb 

fc1 <- ets.model
fc2 <- arima.model
fc3 <- naive.model
fc4 <- nnet.fcast 
fc5 <- fcast.xgb

# fc12, fc13, fc14, fc15
# fc23, fc24, fc25 
# fc34, fc35 
# fc45 
# fc123, fc124, fc125, fc134, fc135, fc145
# fc234, fc235, fc245 
# 
# fc1234, fc1235, fc1345, fc1245, fc2345 
# fc12345 

# copy skeleton of fc1 for ensemble modelling 

fc12 <-fc13 <- fc14 <- fc15 <- fc23 <- fc24 <- fc25 <- fc34 <- fc35 <- fc45 <- fc123 <- fc124 <- fc125 <- 
  fc134 <- fc135 <- fc145 <- fc234 <- fc235 <- fc245 <- fc1234 <- fc1235 <- fc1345 <- fc1245 <- fc2345 <- fc12345 <- fc1


# replace point forecast column with average of the models for respective ensemble 
fc12$mean <- (fc1$mean + fc2$mean) / 2 
fc13$mean <- (fc1$mean + fc3$mean) / 2 
fc14$mean <- (fc1$mean + fc5$mean) / 2 
fc15$mean <- (fc1$mean + fc5$mean) / 2
fc23$mean <- (fc2$mean + fc3$mean) / 2
fc24$mean <- (fc2$mean + fc4$mean) / 2
fc25$mean <- (fc2$mean + fc5$mean) / 2
fc34$mean <- (fc3$mean + fc4$mean) / 2
fc35$mean <- (fc3$mean + fc5$mean) / 2
fc45$mean <- (fc4$mean + fc5$mean) / 2

fc123$mean <- (fc1$mean + fc2$mean + fc3$mean) / 3
fc124$mean <- (fc1$mean + fc2$mean + fc4$mean) / 3
fc125$mean <- (fc1$mean + fc2$mean + fc5$mean) / 3
fc134$mean <- (fc1$mean + fc3$mean + fc4$mean) / 3
fc135$mean <- (fc1$mean + fc3$mean + fc5$mean) / 3
fc145$mean <- (fc1$mean + fc4$mean + fc5$mean) / 3
fc234$mean <- (fc2$mean + fc3$mean + fc4$mean) / 3
fc235$mean <- (fc2$mean + fc3$mean + fc5$mean) / 3
fc245$mean <- (fc2$mean + fc4$mean + fc5$mean) / 3

fc1234$mean <- (fc1$mean + fc2$mean + fc3$mean + fc4$mean) / 4
fc1235$mean <- (fc1$mean + fc2$mean + fc3$mean + fc5$mean) / 4
fc1345$mean <- (fc1$mean + fc3$mean + fc4$mean + fc5$mean) / 4
fc1245$mean <- (fc1$mean + fc2$mean + fc4$mean + fc5$mean) / 4
fc2345$mean <- (fc2$mean + fc3$mean + fc4$mean + fc5$mean) / 4

fc12345$mean <- (fc1$mean + fc2$mean + fc3$mean + fc4$mean + fc5$mean) / 5


# Accuracy using MASE
mase.ensemble <- c(accuracy(fc1, store.weekly.test)[2, 6],
          accuracy(fc2, store.weekly.test)[2, 6],
          accuracy(fc3, store.weekly.test)[2, 6],
          accuracy(fc4, store.weekly.test)[2, 6],
          accuracy(fc5, store.weekly.test)[2, 6],
          accuracy(fc12, store.weekly.test)[2, 6],
          accuracy(fc13, store.weekly.test)[2, 6],
          accuracy(fc14, store.weekly.test)[2, 6],
          accuracy(fc15, store.weekly.test)[2, 6],
          accuracy(fc23, store.weekly.test)[2, 6],
          accuracy(fc24, store.weekly.test)[2, 6],
          accuracy(fc25, store.weekly.test)[2, 6],
          accuracy(fc34, store.weekly.test)[2, 6],
          accuracy(fc35, store.weekly.test)[2, 6],
          accuracy(fc45, store.weekly.test)[2, 6],
          accuracy(fc123, store.weekly.test)[2, 6],
          accuracy(fc124, store.weekly.test)[2, 6],
          accuracy(fc125, store.weekly.test)[2, 6],
          accuracy(fc134, store.weekly.test)[2, 6],
          accuracy(fc135, store.weekly.test)[2, 6],
          accuracy(fc145, store.weekly.test)[2, 6],
          accuracy(fc234, store.weekly.test)[2, 6],
          accuracy(fc235, store.weekly.test)[2, 6],
          accuracy(fc245, store.weekly.test)[2, 6],
          accuracy(fc1234, store.weekly.test)[2, 6],
          accuracy(fc1235, store.weekly.test)[2, 6],
          accuracy(fc1345, store.weekly.test)[2, 6],
          accuracy(fc1245, store.weekly.test)[2, 6],
          accuracy(fc2345, store.weekly.test)[2, 6],
          accuracy(fc12345, store.weekly.test)[2, 6])

mase.ensemble.frame <- data.frame(mase.ensemble)


rownames(mase.ensemble.frame) <- c("e", "a", "v", "n", "x", 
                     "ea", "ev", "en", "ex", 
                     "av", "an", "ax",
                     "vn", "vx",
                     "nx",
                     "eav", "ean", "eax", "evn", "evx", "enx", "avn", "avx", "anx",
                     "eavn", "eavx", "evnx", "eanx", "avnx", "eavnx")


colnames(mase.ensemble.frame) <- "MASE"


mase.ensemble.frame.plotly <- data.frame(mase.ensemble)
mase.ensemble.frame.plotly$Models <- NA
mase.ensemble.frame.plotly$Models <- c("e", "a", "v", "n", "x", 
                                       "ea", "ev", "en", "ex", 
                                       "av", "an", "ax",
                                       "vn", "vx",
                                       "nx",
                                       "eav", "ean", "eax", "evn", "evx", "enx", "avn", "avx", "anx",
                                       "eavn", "eavx", "evnx", "eanx", "avnx", "eavnx")

colnames(mase.ensemble.frame.plotly) <- c('MASE','Models')


# lets plot it out 

plot_ly(mase.ensemble.frame.plotly, x=~Models, y= ~MASE, type = "bar", text = ~Models, color = ~Models) %>%
  layout(title = "List of models and ensemble of models", showlegend = FALSE, xaxis = list(title = "e: ETS, a: ARIMA, v: NAIVE, n: Neural, x: XGB", categoryarray = ~Models, categoryorder = "array"), yaxis = list(title = "Mean Absolute Scalred Error")) 



#' ================================
#' ==========References============ 
#' ================================

# Srihari
#https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8023#43811
#https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8055#44044
#https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8095#44279

# champ David thaler 
#https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/discussion/8028#65096
# 
#http://ideone.com/pUw773

# forecastxgb 
#http://ellisp.github.io/blog/2016/11/06/forecastxgb
