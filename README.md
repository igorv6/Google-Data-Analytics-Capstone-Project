# Google-Data-Analytics-Capstone-Project
Bellabeat Case Study using R

## Project
This a project for the Google Data Analytics Capstone Project.

### Introduction
I am a junior data analyst for the Bellabeat Data Analytics department.
I have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices.
The insights you discover will then help guide marketing strategy for the company. I will present your analysis to the Bellabeat
executive team along with your high-level recommendations for Bellabeat’s marketing strategy.

### Company
Urška Sršen and Sando Mur founded Bellabeat, a technology company that produces smart devices focused on health. Sršen used her artistic background to create attractively designed technologies aimed at informing and inspiring women. Since 2013, Bellabeat has collected data on physical activity, sleep, stress, and reproductive health, enabling women to gain a better understanding of their well-being.
By 2016, the company had opened global offices and launched several products, expanding its presence through online retailers as well. Bellabeat invested in various forms of advertising, prioritizing digital marketing with activities on Google Search, Facebook, Instagram, Twitter, YouTube, and the Google Display Network. Sršen asked the marketing analytics team to analyze the usage data of the smart devices from one of Bellabeat's products to identify growth opportunities and formulate strategic marketing recommendations based on the trends emerging from the analysis.

### Products
- Bellabeat app: The Bellabeat app provides users with health data related to their activity, sleep, stress, menstrual cycle, and mindfulness habits. This data can help users bett er understand their current habits and make healthy decisions. The Bellabeat app connects to their line of smart wellness products.
- Leaf: Bellabeat’s classic wellness tracker can be worn as a bracelet, necklace, or clip. The Leaf tracker connects to the Bellabeat app to track activity, sleep, and stress.
- Time: This wellness watch combines the timeless look of a classic timepiece with smart technology to track user activity, sleep, and stress. The Time watch connects to the Bellabeat app to provide you with insights into your daily wellness.
- Spring: This is a water bottle that tracks daily water intake using smart technology to ensure that you are appropriately hydrated throughout the day. The Spring bott le connects to the Bellabeat app to track your hydration levels.
- Bellabeat membership: Bellabeat also off ers a subscription-based membership program for users. Membership gives users 24/7 access to fully personalised guidance on nutrition, activity, sleep, health and beauty, and mindfulness based on their lifestyle and goals.

### Data Analysis Phases
For this analysis, I will use the 6 phases learnt during the Google Data Analytics course:
- ASK
- PREPARE
- PROCESS
- ANALYZE
- SHARE
- ACT

### Deliverables
1. Clear summary of the business task
2. A description of all data source used
3. Documentation of any cleaning or manipulation of data
4. A summary of analysis
5. Supporting visualizations and key findings
6. Recommendations based on analysis

### 1. ASK
The main questions required from stakeholders that are going to guide my analysis are:
1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat marketing strategy?

### 2. PREPARE
Data source: dataset collected from Mobius: https://www.kaggle.com/arashnic/fitbit.
The dataset has 11 CSV files. Each document represents different quantitative data tracked by Fitbit.
The data is considered long since each row is one time point per subject, so each subject will have data in multiple rows
Every user has a unique ID and different rows tracked by day and time.

Evalutating the data using the ROCCC ( Reliable, Original, Comprehensive, Current, Cited) I found that:
Data is not Reliable since shows only data from 30 women and is a very small sample size that could lead to a sampling bias.
Is not Original since the provenance section show that the data has been preprocessed.
Is Comprehensive because the metrics fitted the needs of the company.
Is not Current since the data was collected almost 8 years ago.

### 3. PROCESS
In order to process, analyse and create visualizations suggesting final recommendations, I used R.
First step was to install & load the packages required for this analysis.





