aucSummary <- function (data, lev = NULL, model = NULL) {

  
  
  
  require(MLmetrics)
  
  
  
  out <- AUC(y_pred = data$pred, y_true = data$obs)
  names(out) <-  "AUC"
  
  if (any(is.nan(out))) out[is.nan(out)] <- NA 
  
  out
}