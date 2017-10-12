
# Kaggle instacart 
# 0.399 xgb, hyperparameters not optimized 




###########################
# Load Libraries ##########
###########################

library(data.table)
library(dplyr)
library(tidyr)

xgb



###########################
# Data prep  ##########
###########################

# Load Data ---------------------------------------------------------------
path <- "D:\\kaggle\\instacart\\raw_data"
modelpath <- "D:\\kaggle\\instacart"

aisles <- fread(file.path(path, "aisles.csv"))
departments <- fread(file.path(path, "departments.csv"))
orderp <- fread(file.path(path, "order_products__prior.csv"))
ordert <- fread(file.path(path, "order_products__train.csv"))
orders <- fread(file.path(path, "orders.csv"))
products <- fread(file.path(path, "products.csv"))

# maximization script 
source(file.path(modelpath,"f1_maximization.R"))


# Reshape data ------------------------------------------------------------
aisles$aisle <- as.factor(aisles$aisle)
departments$department <- as.factor(departments$department)
orders$eval_set <- as.factor(orders$eval_set)
products$product_name <- as.factor(products$product_name)

products <- products %>% 
  inner_join(aisles) %>% inner_join(departments) %>% 
  select(-aisle_id, -department_id)
rm(aisles, departments)

ordert$user_id <- orders$user_id[match(ordert$order_id, orders$order_id)]

orders_products <- orders %>% inner_join(orderp, by = "order_id")

rm(orderp)
gc()





###########################
# Features Engineering ####
###########################


"""

# Feature engineering ===
#' product based features 
#' -prod_order: total number of orders
#' -prod_no_users: total number of distinct users who ordered 
#' -prod_mean_add_to_cart_order: mean add_to_cart_order
#' -prod_median_add_to_cart_order: (havent implement/tested)
#' -prod_recency : how recent was this product bought 
#' -prod_mean_days_since_prior: average days_since_prior_order
#' -prod_dow_most_order: which dow has the prod been bought most often
#' -prod_hour_most_order: what time has the prod been bought most often
#' -prod_frequency : maximum 1. how frequent this product is bought (ndistinct dow / 7)
#' -prod_reorder_probability: total number of 'second time' bought / total number of 'first time' bought
#' -prod_reorder_times 
#' -prod_reorder_ratio 
#' -------------------------
#' user time / product based features ===
#' -user_orders
#' -user_period
#' -user_mean_days_since_prior
#' -user_total_products
#' -user_reorder_ratio
#' -user_distinct_products
#' -user_average_basket
#' -------------------------
#' User-product features === 
#' -up_orders
#' -up_first_order
#' -up_last_order
#' -up_average_cart_position
#' -up_order_rate
#' -up_orders_since_last_order
#' -up_order_rate_since_first_order
#' --------------------------
#' -order_streaks


# side notes: other created User time / product features not good. pulling score down

"""


# Products ----------------------------------------------------------------
prd <- orders_products %>%
  arrange(user_id, order_number, product_id) %>%
  group_by(user_id, product_id) %>%
  mutate(product_time = row_number()) %>%
  ungroup() %>%
  group_by(product_id) %>%
  summarise(
    prod_orders = n(),
    prod_reorders = sum(reordered),
    prod_first_orders = sum(product_time == 1), # from product_time
    prod_second_orders = sum(product_time == 2),
    prod_no_users = n_distinct(user_id),
    prod_mean_add_to_cart_order = mean(add_to_cart_order),
    prod_recency = min(days_since_prior_order, na.rm = T),
    prod_mean_days_since_prior = mean(days_since_prior_order, na.rm = T),
    prod_dow_most_order = as.numeric(names(which.max(table(order_dow)))),
    prod_hour_most_order = as.numeric(names(which.max(table(order_hour_of_day)))),
    prod_frequency = (n_distinct(order_dow) / 7)
  )

prd$prod_reorder_probability <- prd$reorders / prd$prod_orders
prd$prod_reorder_times <- 1 + prd$prod_reorders / prd$prod_first_orders
prd$prod_reorder_ratio <- prd$prod_reorders / prd$prod_orders

prd <- prd %>% select(-prod_reorders, -prod_first_orders, -prod_second_orders)


prd2 <- orders_products %>% filter(reordered == 1) %>% group_by(product_id) %>% 
  summarise(
    prod_no_users_reordered = n_distinct(user_id)
  )

prd <- prd %>% left_join(prd2, by = "product_id")


rm(products,prd2)
gc()

# Users -------------------------------------------------------------------
users <- orders %>%
  filter(eval_set == "prior") %>%
  group_by(user_id) %>%
  summarise(
    user_orders = max(order_number),
    user_period = sum(days_since_prior_order, na.rm = T),
    user_mean_days_since_prior = mean(days_since_prior_order, na.rm = T)
  )

us <- orders_products %>%
  group_by(user_id) %>%
  summarise(
    user_total_products = n(),
    user_reorder_ratio = sum(reordered == 1) / sum(order_number > 1),
    user_distinct_products = n_distinct(product_id)
  )

users <- users %>% inner_join(us)
users$user_average_basket <- users$user_total_products / users$user_orders

us <- orders %>%
  filter(eval_set != "prior") %>%
  select(user_id, order_id, eval_set,
         time_since_last_order = days_since_prior_order)

users <- users %>% inner_join(us)

rm(us)
gc()


# Database ----------------------------------------------------------------

order_stat <- orders_products %>% group_by(order_id) %>% 
  summarise(order_size = n())

orders_products <- orders_products %>% left_join(order_stat, by = "order_id")


rm(order_stat)
gc()

orders_products$add_to_cart_inverted <- orders_products$order_size - orders_products$add_to_cart_order
orders_products$add_to_cart_relative <- orders_products$add_to_cart_order / orders_products$order_size

data <- orders_products %>%
  group_by(user_id, product_id) %>% 
  summarise(
    up_orders = n(),
    up_first_order = min(order_number),
    up_last_order = max(order_number),
    up_average_cart_position = mean(add_to_cart_order),
    up_days_since_prior_mean = mean(days_since_prior_order),
    up_order_dow_mean = mean(order_dow),
    up_order_hour_of_day_mean = mean(order_hour_of_day),
    up_add_to_cart_inverted_mean = mean(add_to_cart_inverted),
    up_add_to_cart_relative_mean = mean(add_to_cart_relative),
    up_reordered_sum = sum(reordered))




rm(orders_products)

data <- data %>% 
  inner_join(prd, by = "product_id") %>%
  inner_join(users, by = "user_id")

#data$order_number_skew <- data$order_number_mean / data$up_last_order
data$up_order_rate <- data$up_orders / data$user_orders
data$up_orders_since_last_order <- data$user_orders - data$up_last_order
data$up_order_rate_since_first_order <- data$up_orders / (data$user_orders - data$up_first_order + 1)
data$up_reordered_ratio <- (data$up_reordered_sum + 1) / data$up_orders 

# adding reordered 
data <- data %>% 
  left_join(ordert %>% select(user_id, product_id, reordered), 
            by = c("user_id", "product_id"))

rm(ordert, prd, users)
gc()


# add in faron's streaks features 
# link: 
# add in streaks 
# if na , then 0

streaks <- fread('order_streaks.csv')
data <- data %>% left_join(streaks, by = c("user_id", "product_id"))
data$order_streak[is.na(data$order_streak)] <- 0


# time based features from sh1ng 
# generate product_period_stats.pkl from lgbm folder via python. Then generate csv for R
product_periods <- fread('product_period_stats.csv')
product_periods[is.na(product_periods)] <- 0 # replace the nas 
data <- data %>% left_join(product_periods, by = c("user_id", "product_id"))

# add back original columns from orders



rm(orders,product_periods)
# Train / Test datasets ---------------------------------------------------
train <- as.data.frame(data[data$eval_set == "train",])
train$eval_set <- NULL
#train$user_id <- NULL
train$product_id <- NULL
train$order_id <- NULL
train$reordered[is.na(train$reordered)] <- 0

test <- as.data.frame(data[data$eval_set == "test",])
test$eval_set <- NULL
test$user_id <- NULL
test$reordered <- NULL

rm(data)
gc()












# caret model 

library(caret)
source(file.path(modelpath,"aucsummary.R"))
user_index <- groupKFold(train$user_id, k=5)


train$user_id <- NULL



train$reordered <- ifelse(train$reordered == 1, "Y", "N")
train$reordered <- as.factor(train$reordered)

fitcontrol <- trainControl(method = "cv", number = 5, savePredictions = "final", summaryFunction = aucSummary, index = user_index, verboseIter = TRUE)

xgb_grid <- expand.grid(nrounds= 90, 
                        max_depth= 6,
                        eta= 0.1, 
                        gamma= 0.7, 
                        colsample_bytree = 0.95, 
                        min_child_weight = 10, 
                        subsample = 0.76
                        )
set.seed(12357)
model_xgb <- train(reordered~., 
                   data = train,
                   method = "xgbTree",
                   tuneGrid = xgb_grid,
                   trControl = fitcontrol,
                   alpha = 2e-05,
                   lambda = 10,
                   metric = "AUC",
                   maximize = TRUE)






# Model -------------------------------------------------------------------

#[90]	train-logloss:0.244667  LB = 0.3959933
#[90]	train-logloss:0.244528  LB = 0.3964455

library(xgboost)

params <- list(
  "objective"           = "reg:logistic",
  "eval_metric"         = "logloss",
  "eta"                 = 0.1,
  "max_depth"           = 6,
  "min_child_weight"    = 10,
  "gamma"               = 0.70,
  "subsample"           = 0.76,
  "colsample_bytree"    = 0.95,
  "alpha"               = 2e-05,
  "lambda"              = 10,
  "nthread"             = 7
)

subtrain <- train
X <- xgb.DMatrix(as.matrix(subtrain %>% select(-reordered)), label = subtrain$reordered)


# 
set.seed(12357)
model <- xgboost(data = X, params = params, nrounds = 100, print_every_n = 50)

importance <- xgb.importance(colnames(X), model = model)
xgb.ggplot.importance(importance)

rm(X, importance, subtrain)
gc()


# Apply model -------------------------------------------------------------
X <- xgb.DMatrix(as.matrix(test %>% select(-order_id, -product_id)))
test$reordered <- predict(model, X)

fwrite(test,"1108_xgb.csv")

# apply faron maximization script
submission <- test %>%
  group_by(order_id) %>%
  summarise(products = exact_F1_max_none(reordered, product_id))



write.csv(submission, file = "submit_1008_prod_feat.csv", row.names = F)





###########################
# References           ####
###########################


# http://www.kdd.org/kdd2016/papers/files/adf0160-liuA.pdf
