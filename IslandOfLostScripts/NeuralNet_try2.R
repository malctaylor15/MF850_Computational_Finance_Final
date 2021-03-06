# Neural Network for regression 

# Import data
data <- read.csv("mf850-finalproject-data.csv")
y <- data$RETMONTH
# Peak at data again 

# Determine test and train size 
test_size <- 300
train_size <- 300

# Store  test and train response variable 

# Test set is last test_size
# Training set is next train_size after test_size 

test_high <- nrow(data)
test_low <- test_high - test_size # Lower row number for test set
train_high <- test_low - 1 # Upper row number for training set
train_low <- train_high - train_size # Lower row number for training set

# Subset the Response variable into test and training sets
y_test <- y[test_low:test_high]
y_train <- y[train_low:train_high]

# Remove Date, Industry, Returns (response variables)
data$Date <- NULL
data$Industry <- NULL
data$RETMONTH <- NULL

# Create training set 
data <- scale(data)
x_test <- data[test_low:test_high, ]
x_train <- data[train_low:train_high, ]

# Some benchmarks for regression and categorical analysis 

# Baseline MSE from guessing the mean for in sample accuracy 
MSE_train <- mean( (y_train - mean(y_train)) ^ 2)
# Baseline MSE from guessing the mean for test (out of sample) accuracy  
MSE_test <- mean( (y_test - mean(y_test)) ^ 2)
MSE_test1 <- mean((y_test - mean(y_train)) ^ 2)


########################
### Neural Network part 
#######################

# Install packages 
#install.packages("neuralnet")
library(neuralnet)

# Format data for neuralnet command 
train_data <- cbind(x_train, y_train)
test_data <- cbind(x_test, y_test)

# Create formula manually (bug in neural net package )
f <- as.formula(c("y_train ~", (paste(colnames(x_train), collapse = " + "))))
f


# Train neural net
nnet1 <- neuralnet(f, data = train_data, hidden = 3, threshold = 0.01, stepmax = 1e5)

# Options for neural net 
names(nnet1)

# In sample accuracy 

# Compute responses from test data 
nnet_train_response <- compute(nnet1, x_train)$net.result
# In sample MSE 
(MSE_train_nnet <- mean((y_train - nnet_train_response)^2))
# Baseline MSE 
MSE_train
# Percent improvement 
(abs(MSE_train - MSE_train_nnet)/MSE_train)

# Out sample predictions
nnet_test_response <- compute(nnet1, x_test)$net.result
# Out sample MSE 
(MSE_test_nnet <- mean((y_test - nnet_test_response) ^ 2))
# Out sample baseline 
MSE_test


# parameter tuning - numberof hidden layers for neural network 

# hidden layers to try from 3 - 51 by 3  
hidden_layers <- seq(from = 3, to = 51, by= 3)
# Pre allocate data frame space
nnet_hidden_layer_df <- data.frame(matrix(0, nrow = 4, ncol = 3))
# Rename columns 
names(nnet_hidden_layer_df)[1:3] <- c("Number of Hidden Layers", "MSE_in", "MSE_out")

for (hl in hidden_layers){
  # Index for storing things in data frame 
  df_index <- hl/3
  
  # Train neural net with varying hidden layer parameter 
  nnet1 <- neuralnet(f, data = train_data, hidden = hl, threshold = 0.01, stepmax = 1e5, rep = 8)

  # In sample accuracy 
  
  # Compute responses from test data 
  nnet_train_response_temp <- compute(nnet1, x_train)$net.result
  # In sample MSE 
  nnet_hidden_layer_df$MSE_in[df_index] <- mean((y_train - nnet_train_response_temp) ^ 2)
  
  # Out sample predictions
  nnet_test_response_temp <- compute(nnet1, x_test)$net.result
  # Out sample MSE 
  nnet_hidden_layer_df$MSE_out[df_index]<- mean((y_test - nnet_test_response_temp) ^ 2)
}
}
