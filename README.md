# Google Data Analytics Capstone: Cyclistic Case Study

### Links:
Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone)

Data Used: [divvy_tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) (Jan 2022 - Dec 2022, Accessed Nov 2023)  

## Introduction
Welcome to the Cyclistic bike-share analysis case study! In this case study, I will perform many real-world tasks of a junior data
analyst. I will be working for a fictional company, Cyclistic, and meet different characters and team members. In order to answer the
key business questions, I will follow the steps of the data analysis process: **ask, prepare, process, analyze, share, and act**.

### Scenario
I will be acting as a junior data analyst working in the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve our recommendations, so they must be backed up with compelling data insights and professional data visualizations.

### Cyclistic
A bike-share program that features more than 5,800 bicycles and 600 docking stations. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes; about 8% of riders use the assistive options. Cyclistic users are more likely to ride for leisure, but about 30% use them to commute to work each day.   
  
Until now, Cyclistic’s marketing strategy relied on building general awareness and appealing to broad consumer segments. One approach that helped make these things possible was the flexibility of its pricing plans: single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.  
  
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, Moreno (the director of marketing and my manager) believes that maximizing the number of annual members will be key to future growth. Rather than creating a marketing campaign that targets all-new customers, Moreno believes there is a very good chance to convert casual riders into members. She notes that casual riders are already aware of the Cyclistic program and have chosen Cyclistic for their mobility needs.  

Moreno has set a clear goal: Design marketing strategies aimed at converting casual riders into annual members. In order to do that, however, the marketing analyst team needs to better understand how annual members and casual riders differ, why casual riders would buy a membership, and how digital media could affect their marketing tactics. Moreno and her team are interested in analyzing the Cyclistic historical bike trip data to identify trends.  

## Ask
### Business Task
Devise marketing strategies to convert casual riders to members.
### Analysis Questions
Three questions will guide the future marketing program:  
1. How do annual members and casual riders use Cyclistic bikes differently?  
2. Why would casual riders buy Cyclistic annual memberships?  
3. How can Cyclistic use digital media to influence casual riders to become members?  

Moreno has assigned me the first question to answer: How do annual members and casual riders use Cyclistic bikes differently?
## Prepare
### Data Source
I will be using Cyclistic’s historical trip data from Jan 2022 to Dec 2022 which can be downloaded [here](https://divvy-tripdata.s3.amazonaws.com/index.html). 
The data has been made available by Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement). These 12 files are organized by month, and have column names that include: **ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng and member_casual**.

## Process
I will be using SQL (specifically PostGreSQL) to explore, combine, clean, and analyze the data.  

### Data Combining
SQL Query: [Data Combining](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Data%20Combining.sql)  
Here the 12 csv files (202201-divvy-tripdata to 202212-divvy-tripdata) are downloaded off the data source provided and combined into a single dataset called tripdata_all, which contains 5,667,717 rows of data.
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/Data%20Combining.png)

### Data Exploring
SQL Query: [Data Exploring](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Data%20Exploring.sql)  
Here I perform some simple checks to familiarize myself with the data before moving on to cleaning and analysis.  

Things I checked for:  
1. Column Types: mostly text, with some doubles for the coordinates and timestamps for the start and end times.
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DE_ColTypes.png)

2. Duplicate Rows: 0 duplicates found.  
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DE_dupes.png)

3. Null Values: first check how many missing values are found in each column.
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DE_NullVals.png)  
Since null values appear to be in paired amounts between 3 sets of 2 columns, I decided to check the consistency of null values between columns.
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DE_NullValsCont.png)  
Observations:
  - start_station_name, end_station_name, and end_lat are all synced up with start_station_id, end_station_id, and end_lng respectively. This means that in all places where start_station_name is null, start_station_id is also null, and the same is true for the other 2 pairs of columns.
  - start_station_name and end_station_name are both null in some rows, but not all.
  - All 5858 rows that are missing end_lat are also missing end_station_name, but missing end_station_name doesn't mean end_lat will also be missing.
 4. Errors in member_casual: Since the member_casual column is related to our business task, I will make sure that it only contains the 2 values 'member' or 'casual', which it does.  
    ![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DE_MemCasErrors.png)
 5. Ride_id length: Finally I will make sure all values in the ride_id column are the same length, which they are  
    ![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DE_RideidErorrs.png)
### Data Cleaning
SQL Query: [Data Cleaning](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Data%20Cleaning.sql)  
Here I make a modified version of tripdata_all called tripdata_clean with the following changes:  
- Removed all rows with missing values
- Added day_of_week and month columns, extracting day_of_week and month respectively from started_at timestamp
- Added trip duration column from difference between started_at and ended_at, displayed in minutes
- Removed outlier trips that had a trip duration of shorter than one minute or longer than one day
    
Here's a view of the clean dataset:
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DCl_TripdataClean.png)  

Just in case, I recheck for null values and duplicate rows, which there are none:  
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DCl_RecheckDupes.png)  
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DCl_RecheckNullVals.png)  

## Analyze 
SQL Query: [Data Analysis](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Data%20Analysis.sql)  
Data Visualization: [Tableau](https://public.tableau.com/app/profile/casey.kwinn/viz/Cyclistic_CaseStudy_Visuals/AVG_Month#1)  
Here I analyze the clean data to answer the following question: How do annual members and casual riders use Cyclistic bikes differently?  

Analysis Queries:

1. Total Trips by Hour:
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_TotHour.PNG)
It appears that members have 2 spikes throughout the day - one at 8am and one around 5pm. Casual riders only have a single spike around 5pm.

2. Total Trips by Day of the Week:
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_TotDow.PNG)
Members appear to ride more often during weekdays, where as casual riders actually spike during weekends.

3. Total Trips by Month:
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_TotMonth.PNG)
Both members and casual riders ride much more during summer months than winter ones.  

4. Average Ride Duration by Hour:
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_AvgHour.PNG)
Casual riders seem to have shorter duration rides during morning and early evening hours, while members have more stable ride duration throughout the day.  

5. Average Ride Duration by Day of the Week:  
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_AvgDow.PNG)  
Both members and casual riders have slightly longer durations during the weekend, with casual riders having a larger increase.  

6. Average Ride Duration by Month:  
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_AvgMonth.PNG)  
Casual riders have a peak around the spring months, trending downwards into winter. Members have a more stable ride duration year round, with a slight peak during summer months.

7. Most Common Start Locations:
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_CommonStarts.PNG)
Casual riders tend to heavily prefer starting in popular downtown locations (especially Streeter Dr & Grand Ave), while members are much more evenly spread out throughout the city.

8. Most Common End Locations:
![image](https://github.com/CaseyKwinn/Google-Data-Analytics-Case-Study-Cyclistic/blob/main/Output%20Images/DV_CommonEnds.PNG)
Very similar trends to start locations.

General Observations:  
Casual Riders: Prefer riding on weekends in recreational areas with much longer but less frequent rides.  
Cyclistic Members: Prefer riding regularly during commute hours of work week in commercial areas with short but frequent rides through the year.  

## Act  
Now that differences between casual riders and members have been found, here are some ideas for marketing strategies that can be used to target casual riders and incentivize them to become members:

1.  Conduct marketing campaigns involving signup deals for new members. Focus these campaigns in areas like Streeter Dr & Grand Ave, as well as other popular ride locations for casual riders.  
2.  Since casual riders prefer longer rides, offer discounts for longer rides, as well as discounts during summer months when riding is more popular.  
3.  Advertise Cyclistic bikes as an enjoyable and effective method of commuting to work. It's much more likely casual riders will purhcase a membership and behave like other members if they are made aware of the possiblilty of using bikes as a way to commute to work.  
