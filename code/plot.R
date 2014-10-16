## Simple plotting script ##

# Dependencies
library(ggplot2)
library(reshape2)

# Loading data
m <- read.csv('data/mailchimp.csv')
t <- read.csv('data/twitter.csv')
r <- read.csv('data/repository.csv')

# Cleaning
t$Week <- as.Date(t$Week, "%m/%d/%Y")
r <- melt(r, id = 'Date_and_Time')
r$Date_and_Time <- as.Date(r$Date_and_Time)

## CKAN Visual
datasets <- r[r$variable == 'Number_of_Datasets',]
users_orgs <- r[r$variable == 'Number_of_Organizations' | r$variable == 'Number_of_Users', ]

# Number of Datasets
dplot <- ggplot(datasets) + theme_bw() +
  geom_line(aes(Date_and_Time, value), color = "#1EBFB3", size = 1.3)

ggsave('plot/number-of-datasets.pdf', dplot, width = 400, height = 160, units = 'mm')

# Number of Organizations and Users
oplot <- ggplot(users_orgs) + theme_bw() +
  geom_line(aes(Date_and_Time, value, color = variable), size = 1.3)

ggsave('plot/number-of-organizations-users.pdf', oplot, width = 400, height = 160, units = 'mm')



# Number of Followers
tplot <- ggplot(t) + theme_bw() +
  geom_line(aes(Week, Followers), size = 1.3)

ggsave('plot/number-of-followers.pdf', tplot, width = 400, height = 160, units = 'mm')
