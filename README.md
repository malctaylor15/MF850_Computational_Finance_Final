# MF850_Computational_Finance_Final

## About this Project 

This project was a group effort for Professor Schwenkler's Advanced Computational Methods class in the Spring of 2016. 
My group partners were  
[Max Yellen](https://github.com/myellen/)  
[Izzat Ghuneim](https://www.izzatghuneim.com/)  
[Cassandra MacKay](https://www.linkedin.com/in/cassandralmckay/)  

The goal of this assignment was to use fundamental data about several companies to build forecasting models. 
There were two parts to this project. The first part was to forecast the monthly return of several public companies. 
The second part was to determine whether the change was positive or negative. The models did not need to be consistent, 
meaning one model could predict that the company stock would be higher while the forecast from the other model was negative. 

For the continous forecast model, we use an ensemble of 3 different optimized models. We have a weighted voting system that averages the 
predictions an elastic net regression, random forest and deep neural network. We find the weights for the ensemble by
averaging the R-square for each model.  

For the growth and fall predictions, we also use an ensemble of 3 optimized models. We weights in this models are based on the normalized accuracy. 

## Data Preparation 

To prepare our test and training set, we had to preform several preprocessing steps. 
1. Lag the data 
The monthly returns were aligned with the monthly fundamentals as they were reported. As we were trying to predict the next month's returns using the current 
fundamental data. 
2. Used one-hot encoding on the Industry variable. The industry column should not be treated as a nominal variable as there is no proper ordering for the indsutries. 
Using one hot encoding on this variable expanded the number of variables by 212. We hoped that there would be enough companies in each industry to prevent the model 
from overfitting at the company level. 
3. We also removed the SP500 as it would be the same across all the variables 



## File Structure

### Build Model R Scripts 
The folder named Build Model R Scripts has the R scripts for each of the sub models that were built for both parts of the assignment. 
For the Linear_Ridge_Lasso, we use cross validation and elastic net to search for the optimal parameters for the linear regression. 

### Data Augmentations 
In this folder, we have various versions of the data set. We have cleaned versions after we scale the data and remove columns we do not want. 
We also have splits of the data into test-train sets. 



## Potential improvements

1. Include SP500 
We could also include the SP500 to mimic the CAPM model. 
 


Final project for MF850 Advanced Computational Methods of Mathematical Finance

Master: [![Build Status](https://travis-ci.org/myellen/MF850_Computational_Finance_Final.svg?branch=master)](https://travis-ci.org/myellen/MF850_Computational_Finance_Final)
Development: [![Build Status](https://travis-ci.org/myellen/MF850_Computational_Finance_Final.svg?branch=development)](https://travis-ci.org/myellen/MF850_Computational_Finance_Final)
