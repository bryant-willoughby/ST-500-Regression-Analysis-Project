----------------------------------------
Course Description - STATS 500: Regression Anlaysis 

This class will focus on linear and generalized linear models, and will include
topics such as building regression models and conducting inference and model
checking, variable selection, shrinkage estimators (e.g. ridge regression,
LASSO), generalized linear models, etc. This course aims to introduce the basic
concepts and statistical methods that have been commonly used in practice. After
finishing this course, students should have the basic skills to analyze data sets
collected under simple and standard designs.

Consult Course_Materials for additional details. 

----------------------------------------
STATS 500 Final Project – Micromobility Linear Modeling
Author: Bryant Willoughby
Date: December 2025

----------------------------------------
Project Summary
This repository contains an end-to-end linear modeling workflow analyzing
weekday micromobility trips from Austin, Texas (2018). The goal is to predict
log-transformed trip distance using temporal, spatial, and operational
predictors. The workflow includes data cleaning, exploratory analysis,
hierarchical linear modeling, and penalized regression (ridge, lasso,
elastic net).

----------------------------------------
Key Data Files
austin_micromobility.csv     
austin_micromobility.csv
    - Raw dataset downloaded from the Austin Open Data Portal.
        - available at https://data.austintexas.gov/Transportation-and-Mobility/Shared-Micromobility-Vehicle-Trips-2018-2022-/7d8e-dm7r/about_data 
    - Contains all micromobility trips (bike + scooter), 2018 weekday subset.
austin_micromobility_metadata.txt – Variable descriptions
traindf.rds                     – Cleaned training dataset (70%)
testdf.rds                      – Cleaned testing dataset (30%)

----------------------------------------
RMarkdown Files
DataManipulation.Rmd
  - Cleans raw data, recodes variables, creates engineered features.
  - Saves (intermediate) traindf.rds and (intermediate) testdf.rds.

EDA.Rmd
  - Exploratory plots and summaries.
  - Identifies curvature and interaction structure motivating models.
  - Saves traindf.rds and testdf.rds 

PreliminaryModeling.Rmd
  - Builds interpretable hierarchical models, culminating in M7.
  - Performs diagnostic checks and influence analysis.
  - Tests WLS and robust regression (both ineffective).

AdvancedModeling.Rmd
  - Expands feature space to 430 predictors (main effects, interactions, quadratics).
  - Fits ridge, lasso, and elastic net using sparse matrices + parallelization.
  - Cross-validates models and evaluates RMSE.

----------------------------------------
Results Summary
- M7 provides interpretability but limited predictive accuracy.
- Penalized models (lasso/elastic net) offer small RMSE improvements.
- All linear models exhibit systematic residual curvature:
  → the true mean function is nonlinear.

----------------------------------------
Repository Purpose
This repo documents a full linear-modeling pipeline for a large urban
mobility dataset and provides a reproducible structure for future modeling
extensions (e.g., GAMs, splines, nonlinear ML methods).

