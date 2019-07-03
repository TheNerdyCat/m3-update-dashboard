##################################################
## Project:           M3 Update Dashboard
## Script purpose:    Access the Twitter Streaming API and scrape data about m3 traffic  
## Date:              2019/07/02
## Author:            Edward Sims
##################################################

setwd('C:/Users/Edward Sims/Documents/ml_projects/nerdycat/m3-update-dashboard')


# Import libraries --------------------------------------------------------


# load twitter library - the rtweet library is recommended now over twitteR
library(rtweet)
# plotting and pipes - tidyverse!
library(ggplot2)
library(dplyr)
# text mining library
library(tidytext)
library(lubridate)

# API credentials ---------------------------------------------------------


# whatever name you assigned to your created app
appname <- "m3-update-dashboard"
## api key (example below is not a real key)
consumer_key <- "xxx"
## api secret (example below is not a real key)
consumer_secret <- "xxx"
access_token <- "xxx"
access_secret <- "xxx"


# create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = consumer_key,
  consumer_secret = consumer_secret,
  access_token=access_token,
  access_secret=access_secret)



# Scrape API --------------------------------------------------------------



tweets <- search_tweets(q = "-filter:retweets m3 congestion",
                        n = 500,
                        lang = 'en')

cols_keep <- c('created_at','screen_name','text','location','country')

tweets_sub <- tweets[, cols_keep]
this_week <- today() - 7
tweets_this_week <- as.data.frame(tweets_sub[tweets_sub$created_at >= this_week, ])
tweets_this_week <- tweets_this_week[tweets_this_week$screen_name != 'CapeTownFreeway', ]
tweets_this_week <- tweets_this_week[tweets_this_week$screen_name != 'TrafficSA1', ]
tweets_this_week <- tweets_this_week[tweets_this_week$screen_name != 'netstartraffic', ]
tweets_this_week <- tweets_this_week[tweets_this_week$screen_name != 'QLDTrafficMetro', ]


# Rewrite the script hourly
write.csv(tweets_this_week, 'tweets.csv')








