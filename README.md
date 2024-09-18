# Google-Data-Analytics-Capstone-Project
Bellabeat Case Study using R

## Project
This is a project for the Google Data Analytics Capstone Project.

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
### 4. ANALYZE
Let's start our exploratory analysis
```r
daily_activity %>% 
  select(totalsteps, totaldistance, sedentaryminutes, calories) %>% 
  summary()
```
![image](https://github.com/user-attachments/assets/2c702112-1e83-4c0a-a4e9-67dfc11dc3b7)

We can see that the AVG of steps per day are 7406 steps (recommended 7000-8000 per day). The AVG distance is 5245 while the avg sedentary minutes are 991 (~17 hours) that need to be reduced. 
The avg of calories per day are 2304.

Now that we have a summary of steps, distance, sedentary minutes and calories, let's see divided the users by their number of steps
using a classification 0-4999 steps "Sedentary", 5000-7499 "Light Active", 7500-9999 Moderately Active, 10000-12499 "Active" >12500 "Very Active".
Before creating classification fo users a need to create a new dataframe calculating  AVG steps, calories and daily sleep per day for each users.
```r
daily_average <- daily_activity_sleep %>% 
  group_by(id) %>% 
  summarise(avg_daily_steps = mean(totalsteps), avg_daily_calories = mean(calories), avg_daily_sleep = mean(totalminutesasleep))
```
Now I classify our users by the daily average step:
```r
user_type <- daily_average %>% 
  mutate(user_type = case_when(
    avg_daily_steps < 4999 ~ "sedentary",
    avg_daily_steps >= 5000 & avg_daily_steps < 7499 ~ "light active",
    avg_daily_steps >= 7500 & avg_daily_steps < 9999 ~ "moderately active",
    avg_daily_steps >= 10000 & avg_daily_steps < 12500 ~ "active",
    avg_daily_steps > 12500 ~ "very active"
  ))
```
Let's see the distribution with a bar chart
```r
user_counts <- user_type %>%
  group_by(user_type) %>%
  summarise(count = n())

user_counts$user_type <- factor(user_counts$user_type, levels = c("sedentary","light active","moderately active",
                                                                "active","very active"))
                                                                
ggplot(user_counts, aes(x = user_type, y = count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = count), vjust = -0.5) +  # Aggiungi il conteggio sopra le barre
  labs(title = " Distribution of Users per Category",
       x = "",
       y = "") +
  theme_minimal()
```
![image](https://github.com/user-attachments/assets/3e6a452f-281e-45cf-a589-e21fa20cf23a)

In our small sample, we can see that most of the user are not active.

Let get more insights from the user analyzing their habits during the weekdays:
```r
# Converting column with weekday
weekday_step_sleep <- daily_activity_sleep %>% mutate(weekday = weekdays(date))
head(weekday_step_sleep)

#ordering the weekday
weekday_step_sleep$weekday <- factor(weekday_step_sleep$weekday, levels = c("Monday","Tuesday","Wednesday","Thursday",
                                                                            "Friday","Saturday","Sunday"))

#Calculating the avg step and sleep for weekday
weekday_step_sleep <-weekday_step_sleep%>%
  group_by(weekday) %>%
  summarize (daily_steps = mean(totalsteps), daily_sleep = mean(totalminutesasleep))

create a column chart

ggarrange(
  ggplot(weekday_step_sleep) +
    geom_col(aes(weekday, daily_steps), fill = "#006699") +
    geom_hline(yintercept = 7500) +
    labs(title = "Daily steps per weekday", x= "", y = "") +
    theme(axis.text.x = element_text(angle = 45,vjust = 0.5, hjust = 1)),
  ggplot(weekday_step_sleep, aes(weekday, daily_sleep)) +
    geom_col(fill = "#ff6833") +
    geom_hline(yintercept = 480) +
    labs(title = "Minutes asleep per weekday", x= "", y = "") +
    theme(axis.text.x = element_text(angle = 45,vjust = 0.5, hjust = 1))
)
```
![image](https://github.com/user-attachments/assets/5f283942-7ec9-4072-b749-736a51d23ef1)

From the charts, we see that each days excluding Sunday is over the recommendations step (7500)
Saturday is the day with maximum avg steps, while in the middle of the week users take fewer steps.
An important insight from the second graphs is that every users sleep less than what recommended (8hours).

Getting deeper into our analysis we want to know when users are more active in a day. We'll use the hourly data frame separating date&time in different column
```r
hourly_steps <- hourly_steps %>%
  separate(date_time, into = c("date", "time"), sep= " ") %>%
  mutate(date = ymd(date))

head(hourly_steps)
```
![image](https://github.com/user-attachments/assets/c1c98722-d626-43a8-91a2-13830699c09e)

Then I calculate the AVG steps per hour and put it in a graph:
```r
hourly_steps %>%
  group_by(time) %>%
  summarize(average_steps = mean(steptotal)) %>%
  ggplot() +
  geom_col(mapping = aes(x=time, y = average_steps, fill = average_steps)) + 
  labs(title = "Hourly steps throughout the day", x="", y="") + 
  scale_fill_gradient(low = "green", high = "red")+
  theme(axis.text.x = element_text(angle = 90))
```
![image](https://github.com/user-attachments/assets/21e669ba-835c-45b0-bd2f-d17c0b94f0c2)

We can see that users are more active between 12am-14pm and 17pm and 19pm.
Max steps are during 18pm where we can assume that people finished their working hours and goes home.

Let's analyze correlations between variables:
Total steps and calories

```r
ggplot(data = daily_activity, aes(x = totalsteps, y = calories)) + 
  geom_point() + geom_smooth() + labs(title ="Total Steps vs. Calories")
```
![image](https://github.com/user-attachments/assets/9fe5de56-f7df-49de-a900-4578760de58f)

We can see a positive correlation between total steps taken and the amount of calories burned.​
Calculating the correlation we obrain a coefficient of 0.59 between total steps per day and calories consumed per day indicates a moderate positive correlation
```r
correlation_totalstepsVScalories <- cor(daily_activity$totalsteps, daily_activity$calories, use = "complete.obs")
print(correlation_totalstepsVScalories)
```
Total steps and total time in bed
```r
ggplot(data = daily_activity_sleep, aes(x = totalsteps, y = totaltimeinbed)) + 
  geom_point() + geom_smooth() + labs(title ="Total steps VS total time in bed")
```
![image](https://github.com/user-attachments/assets/ee90ec3d-7f1d-4c4a-bbb4-ea55792b41fe)

```r
correlation_totalstepsVStotaltimeinbed<- cor(daily_activity_sleep$totalsteps, daily_activity_sleep$totaltimeinbed, use = "complete.obs")
print(correlation_totalstepsVStotaltimeinbed)
```

Calculating the correlation betwen thse two variables we obtain a value of -0.166 suggesting that there is not a strong relationship between these two variables.

Now that we have showed insights on habits of users. Let's see how often the users use their devices
Reply to this question can help us to plan our marketing strategy.
```r
daily_use <- daily_activity_sleep %>%
  group_by(id) %>%
  summarize(days_used=sum(n())) %>%
  mutate(usage = case_when(
    days_used >= 1 & days_used <= 10 ~ "low use",
    days_used >= 11 & days_used <= 20 ~ "moderate use", 
    days_used >= 21 & days_used <= 31 ~ "high use", 
  ))

head(daily_use)
```
In order to create the visualization that shows the distribution of users, I create a percentage data frame to better visualize the results:
```r
daily_use <- daily_activity_sleep %>%
  group_by(id) %>%
  summarize(days_used=sum(n())) %>%
  mutate(usage = case_when(
    days_used >= 1 & days_used <= 10 ~ "low use",
    days_used >= 11 & days_used <= 20 ~ "moderate use", 
    days_used >= 21 & days_used <= 31 ~ "high use", 
  ))

head(daily_use_percent)
```
![image](https://github.com/user-attachments/assets/cec196d5-85fc-455b-9578-6e130585e7b2)

In order to create the visualization that shows the distribution of users, I create a percentage
data frame to better visualize the results:
```r
daily_use_percent <- daily_use %>%
  group_by(user_type) %>%
  summarise(total = n()) %>%
  mutate(totals = sum(total)) %>%
  group_by(user_type) %>%
  summarise(total_percent = total / totals) %>%
  mutate(labels = scales::percent(total_percent))

head(daily_use_percent)
```
![image](https://github.com/user-attachments/assets/8bb9638b-41f4-4566-80b0-c106bd233155)

50% of the users of our sample use their device frequently — between 21 to 31 days. 12% are moderate users (they use their device for 11 to 20 days). 38% of our sample rarely used their device.

##### Summary of findings
- Sedentary minutes are high (17h) and need to be reduced
- Our sample consists mostly of nonsports people
- Saturday is the day when most steps are taken
- 12am-14pm and 17pm-19pm are the times when users are most active
- Between total daily steps and total time in bed there is a moderately positive correlation while between total daily steps and total time in bed there is no correlation
- Most users use their device frequently while there is a 38% of users who rarely use it

### 5. ACT
Bellabeat's mission is to empower women by providing them with the data to discover themselves. In order to get more and accurate insights, I suggest to collect more data and include more users in our sample
After our analysis we have found different trend and insights that can help may help us our marketing strategies.
- Bellebeat app must include daily short notification including reminders and quick pills about the important of fitness activity. From our sample we see that the most users are not so active, so Bellabeat need to encourage people to be more active. Since since we are always in touch with social media, Bellebeat needs to find a way for which its notifications are original and fun. Creating challenges between users and reward with small prize may be a good idea.
- Based on the analysis we got an important finding, users have less than the recommended amount of sleep in a day. Bellabeat with his interaction with users must convey the importance of sleep the recommend hour. This is an important element to include in Bellebeat's notification
- Bellebeat product must be fashion and elegant, products that you can wear and use everyday in any occasion
