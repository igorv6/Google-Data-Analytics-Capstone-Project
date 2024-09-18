# Installation of packages and libraries required for my analysis
install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")
install.packages("readr")
install.packages("janitor")
install.packages("lubridate")
install.packages("ggplot2")
install.packages("ggpubr")

library(tidyverse)
library(skimr)
library(janitor)
library(readr)
library(janitor)
library(lubridate)
library(ggplot2)
library(ggpubr)

Sys.setlocale("LC_TIME", "C")

# Setting work directory
setwd("C:\\Users\\Huawei\\OneDrive\\Desktop\\Fitabase Data 4.12.16-5.12.16")

# Importing dataset
daily_activity <- read.csv("dailyActivity_merged.csv")
daily_steps <- read.csv("dailySteps_merged.csv")
daily_sleep <- read.csv("SleepDay_merged.csv")
hourly_steps <- read.csv("hourlySteps_merged.csv")
hourly_calories <- read.csv("hourlyCalories_merged.csv")
hourly_intensities <- read.csv("hourlyIntensities_merged.csv")
weight <- read.csv("weightLogInfo_merged.csv")

# Preview of data
head(daily_activity)
head(daily_sleep)
head(daily_steps)
head(hourly_calories)
head(hourly_intensities)
head(hourly_steps)
head(weight)

# Structure of data
str(daily_activity)
str(daily_sleep)
str(daily_steps)
str(hourly_calories)
str(hourly_intensities)
str(hourly_steps)
str(weight)

# Checking unique value for the field ID
n_unique(daily_activity$Id)
n_unique(daily_sleep$Id)
n_unique(daily_steps$Id)
n_unique(hourly_calories$Id)
n_unique(hourly_intensities$Id)
n_unique(hourly_steps$Id)
n_unique(weight$Id)
# dataset contains 33 partecipants except for daily_sleep and weigh data that contain 24 and 8 partecipants.
# table weight shows only 8 partecipants that is too small to include in our analysis

# Checking deplicates
sum(duplicated(daily_activity))
sum(duplicated(daily_sleep))
sum(duplicated(daily_steps))
sum(duplicated(hourly_calories))
sum(duplicated(hourly_intensities))
sum(duplicated(hourly_steps))

# daily_sleep contains 3 duplicates. I will delet duplicates
daily_sleep <- daily_sleep %>% 
  distinct()

#Deleting NA values
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

# Clean and rename columns. I want to ensure that column names are using right syntax and same format in all dataframes
# since we will merge them later on. I change the format of all columns to lower case
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

# After changing column names to lowe case, we clean date format for daily_activity and daily_sleep since I'm going to
# merge both data frames. For hourly_calories, hourly_intensities and hourly_steps, I convert date string to date-time
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

# merging datasets
daily_activity_sleep <- merge(daily_activity, daily_sleep, by=c ("id", "date")) 
view(daily_activity_sleep)

# ANALYZING PHASE

#1 Exploratory 
daily_activity %>% 
  select(totalsteps, totaldistance, sedentaryminutes, calories) %>% 
  summary()
# we can see that the AVG of steps by day are 7406 steps (recommended 7000-8000 per day). The AVG distance is 5245 while
# the avg sedentary minutes are 991 (~17 hours) that need to be reduced. The avg of calories per day are 2304 

#Now that we have a summary of steps, distance, sedentary minutes and calories, let's see divided the users by their number of steps
# using a classification 0-4999 steps "Sedentary", 5000-7499 "Light Active", 7500-9999 Moderately Active, 10000-12499 "Active"
# >12500 "Very Active"
#Before creating classification fo users a need to create a new dataframe calculating  AVG steps, calories and daily sleep per day for each users
daily_average <- daily_activity_sleep %>% 
  group_by(id) %>% 
  summarise(avg_daily_steps = mean(totalsteps), avg_daily_calories = mean(calories), avg_daily_sleep = mean(totalminutesasleep))

# Now I classify our users by the daily average steps
user_type <- daily_average %>% 
  mutate(user_type = case_when(
    avg_daily_steps < 4999 ~ "sedentary",
    avg_daily_steps >= 5000 & avg_daily_steps < 7499 ~ "light active",
    avg_daily_steps >= 7500 & avg_daily_steps < 9999 ~ "moderately active",
    avg_daily_steps >= 10000 & avg_daily_steps < 12500 ~ "active",
    avg_daily_steps > 12500 ~ "very active"
  ))


# let's see the distribution with a bar chart
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
# in our small sample, we can see that most of the users are not active 

# Let get more insight from the users analyzing their habits during the weekdays
weekday_step_sleep <- daily_activity_sleep %>% mutate(weekday = weekdays(date))
head(weekday_step_sleep)
# ordering the weekday
weekday_step_sleep$weekday <- factor(weekday_step_sleep$weekday, levels = c("Monday","Tuesday","Wednesday","Thursday",
                                                                            "Friday","Saturday","Sunday"))

#Calculating the avg step and sleep for weekday
weekday_step_sleep <-weekday_step_sleep%>%
  group_by(weekday) %>%
  summarize (daily_steps = mean(totalsteps), daily_sleep = mean(totalminutesasleep))

# let's create a column chart

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

# From the charts, we see that each days excluding Sunday is over the recommendations step (7500)
# Saturday is the day with maximum avg steps, while in the middle of the week users take fewer steps.
#  An important insight from the second graphs is that every users sleep less than what recommended (8hours)
 
# Getting deeper into our analysis we want to know when users are more active in a day
# We will use the hourly_steps data frame and separate date time column

hourly_steps <- hourly_steps %>%
  separate(date_time, into = c("date", "time"), sep= " ") %>%
  mutate(date = ymd(date))

head(hourly_steps)
#calculating the avg steps per hour and put it in a graph
hourly_steps %>%
  group_by(time) %>%
  summarize(average_steps = mean(steptotal)) %>%
  ggplot() +
  geom_col(mapping = aes(x=time, y = average_steps, fill = average_steps)) + 
  labs(title = "Hourly steps during the day", x="", y="") + 
  scale_fill_gradient(low = "green", high = "red")+
  theme(axis.text.x = element_text(angle = 90))
# We can see that users are more active between 12am-14pm and 17pm and 19pm.
# Max steps are during 18pm where we can assume that people finished their working hours and goes home

# Let's see some correlations between variables using:
# total steps and calories
ggplot(data = daily_activity, aes(x = totalsteps, y = calories)) + 
  geom_point() + geom_smooth() + labs(title ="Total Steps vs. Calories")

correlation_totalstepsVScalories <- cor(daily_activity$totalsteps, daily_activity$calories, use = "complete.obs")
print(correlation_totalstepsVScalories)
# total time in bed and total steps
ggplot(data = daily_activity_sleep, aes(x = totalsteps, y = totaltimeinbed)) + 
  geom_point() + geom_smooth() + labs(title ="Total steps VS total time in bed")

correlation_totalstepsVStotaltimeinbed<- cor(daily_activity_sleep$totalsteps, daily_activity_sleep$totaltimeinbed, use = "complete.obs")
print(correlation_totalstepsVStotaltimeinbed)

# Now that we have showed insights on habits of users. Let's see how often the users use their devices
# Rerply to this question can help us to plan our marketing strategy
daily_use <- daily_activity_sleep %>%
  group_by(id) %>%
  summarize(days_used=sum(n())) %>%
  mutate(user_type = case_when(
    days_used >= 1 & days_used <= 10 ~ "low use",
    days_used >= 11 & days_used <= 20 ~ "moderate use", 
    days_used >= 21 & days_used <= 31 ~ "high use", 
  ))

head(daily_use)


# In order to create the visualization that shows the distribution of users, I create a percentage
# data frame to better visualize the results

daily_use_percent <- daily_use %>%
  group_by(user_type) %>%
  summarise(total = n()) %>%
  mutate(totals = sum(total)) %>%
  group_by(user_type) %>%
  summarise(total_percent = total / totals) %>%
  mutate(labels = scales::percent(total_percent))

head(daily_use_percent)

ggplot(daily_use_percent, aes(x = "", y = total_percent, fill = user_type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(fill = "User Type", title = "Percentage Distribution of User Types") +
  geom_text(aes(label = labels), position = position_stack(vjust = 0.5))

