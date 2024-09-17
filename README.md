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
The dataset has 18 CSV files. Each document represents different quantitative data tracked by Fitbit.
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
```r
library(tidyverse)
library(skimr)
library(janitor)
library(readr)
library(janitor)
library(lubridate)
```
After that I imported dataset for my analysis

```r
daily_activity <- read.csv("dailyActivity_merged.csv")
daily_steps <- read.csv("dailySteps_merged.csv")
daily_sleep <- read.csv("SleepDay_merged.csv")
hourly_steps <- read.csv("hourlySteps_merged.csv")
hourly_calories <- read.csv("hourlyCalories_merged.csv")
hourly_intensities <- read.csv("hourlyIntensities_merged.csv")
weight <- read.csv("weightLogInfo_merged.csv")
```
Once I have imported the dataset, I start analyzing the data contained inside the dataframe, using the function head() and str()

```r
# Preview of data
head(daily_activity)
head(daily_sleep)
head(daily_steps)
head(hourly_calories)
head(hourly_intensities)
head(hourly_steps)
head(weight)
```
![image](https://github.com/user-attachments/assets/4542acf5-26e5-40cd-a816-64e91d0454fd)



```r
# Structure of data
str(daily_activity)
str(daily_sleep)
str(daily_steps)
str(hourly_calories)
str(hourly_intensities)
str(hourly_steps)
str(weight)

```
![image](https://github.com/user-attachments/assets/ffa4465a-b1f2-4bc1-a7ee-48e11bb6c870)

Once I had a preview of data and structure, I start to use if there some duplicate and NA values in order to star the cleaning process.
1. I check the unique users included in these dataframes
```r
n_unique(daily_activity$Id)
n_unique(daily_sleep$Id)
n_unique(daily_steps$Id)
n_unique(hourly_calories$Id)
n_unique(hourly_intensities$Id)
n_unique(hourly_steps$Id)
n_unique(weight$Id)
```
All datasets contains 33 partecipants except for daily_sleep and weigh data that contain 24 and 8 users.
table weight shows only 8 users that is too small to include in our analysis.

2. Check for any duplicates in the data
  ```r
sum(duplicated(daily_activity))
sum(duplicated(daily_sleep))
sum(duplicated(daily_steps))
sum(duplicated(hourly_calories))
sum(duplicated(hourly_intensities))
sum(duplicated(hourly_steps))
```
Daily_sleep contains 3 duplicates. I will delet them
  ```r
daily_sleep <- daily_sleep %>% 
  distinct()
```
After delete duplicates values, I'm going to delete NA values inside the dataframes
  ```r
daily_activity <- daily_activity %>%
  drop_na()
daily_sleep <- daily_sleep %>% 
  drop_na()
daily_steps <- daily_steps %>% 
  drop_na()
hourly_calories <- hourly_calories %>% 
  drop_na()
hourly_intensities <- hourly_intensities %>% 
  drop_na()
hourly_steps <- hourly_steps %>% 
  drop_na()
```
3. Clean and renames columns
   I want to ensure that columns names are using the right syntax and same format in all dataframes. Since I need to merge them later on
   I change the format of all columns to lower case
```r
clean_names(daily_activity)
daily_activity <- rename_with(daily_activity, tolower)

clean_names(daily_sleep)
daily_sleep <- rename_with(daily_sleep, tolower)

clean_names(daily_steps)
daily_steps <- rename_with(daily_steps, tolower)

clean_names(hourly_calories)
hourly_calories <- rename_with(hourly_calories, tolower)

clean_names(hourly_intensities)
hourly_intensities <- rename_with(hourly_calories, tolower)

clean_names(hourly_steps)
hourly_steps <- rename_with(hourly_steps, tolower)

clean_names(sleepDay_merged)
sleepDay_merged <- rename_with(sleepDay_merged, tolower)
```
4. Change data format
 ```r
daily_activity <- daily_activity %>% 
  rename(date = activitydate) %>% 
  mutate(date = as_date(date, format = "%m/%d/%Y"))

daily_sleep <- daily_sleep %>%
  rename(date = sleepday) %>%
  mutate(date = as_date(date,format ="%m/%d/%Y %I:%M:%S %p" , tz=Sys.timezone()))

hourly_calories <- hourly_calories %>% 
  rename(date_time = activityhour) %>% 
  mutate(date_time = as.POSIXct(date_time, format ="%m/%d/%Y %I:%M:%S %p" , tz=Sys.timezone()))

hourly_intensities <- hourly_intensities %>% 
  rename(date_time = activityhour) %>% 
  mutate(date_time = as.POSIXct(date_time, format ="%m/%d/%Y %I:%M:%S %p" , tz=Sys.timezone()))

hourly_steps<- hourly_steps %>% 
  rename(date_time = activityhour) %>% 
  mutate(date_time = as.POSIXct(date_time, format ="%m/%d/%Y %I:%M:%S %p" , tz=Sys.timezone()))
```  

5. Marging dataframes
 
```r
daily_activity_sleep <- merge(daily_activity, daily_sleep, by=c ("id", "date")) 
view(daily_activity_sleep)
```  


