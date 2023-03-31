#Loading libraries
library(ggplot2)
library(dplyr)
library(janitor)
library(tidyr)
library(RColorBrewer)
library(car)
library(psych)
library(imputeTS)
library(corrplot)
library(MASS)
library(leaps)
library(readr)
library(plotly)
library(kableExtra)
library(plotly)
library(rjson)
library(DT)
library(lattice)
library(caret)
library(pROC)


library(readr)
X2016Election_3 <- read_csv("2016Election-3.csv")
df=X2016Election_3
#Removing NA
df=na.omit(df)
describe(df)

kbl(head(df)) %>%
  kable_styling()

#Remove empty rows and columns
df=remove_empty(df,which=c("rows","cols"),quiet=TRUE)
names(df)


#check for NA's
knitr::kable(sum(is.na(df)),col.names="No. of NAs")

#Descriptive Statistics Table
stat_table <- as.data.frame(psych::describe(df))
stat_table <- subset(stat_table, select=c("n","mean","sd","min","max","range")) 
stat_table <- stat_table %>%          
  mutate_if(is.numeric,
            round,
            digits = 1)

kbl(stat_table) %>%
  kable_styling()
#bar graph for total votes obtained over the years
df$Voters.T.R_2016=df$`Total Votes 2016`/df$`Total Voting Age Population(2011 -2015)`
df$Voters.T.R_2012=df$`Total Votes 2012`/df$`Total Voting Age Population(2011 -2015)`


year<-c("2008","2012","2016")
totalvotes<-c(sum(df$`Total Votes 2008`),sum(df$`Total Votes 2012`),sum(df$`Total Votes 2016`))
data <- data.frame(year, totalvotes)
fig1 <- plot_ly(data, x = ~data$year, y = ~data$totalvotes, type = 'bar'	,	name="Total votes recieved over the years")
fig <- fig %>% layout(
  title = "Total votes recieved over the years"
) 
fig1

#line graph for total votes received by each party
year<-c("2012","2016")
voters_ratio<-c(mean(df$Voters.T.R_2012),mean(df$Voters.T.R_2016))
data <- data.frame(year,voters_ratio)
fig <- plot_ly(data, x = ~year, y = ~voters_ratio, type = 'scatter', mode = 'lines+markers',name="Voters Turn out Ratio")
#fig <- fig %>% add_trace(y = ~Republic_Party, name = 'Republic Party', mode = 'lines+markers') 
fig

#line graph for total votes received by each party
year<-c("2011","2012","2013","2014","2015")
Unemployemt_rate<-c(mean(df$`Unemployment Rate 2011`),mean(df$`Unemployment Rate 2012`),mean(df$`Unemployment Rate 2013`),mean(df$`Unemployment Rate 2014`),mean(df$`Unemployment Rate 2015`))
data <- data.frame(year,Unemployemt_rate)
fig <- plot_ly(data, x = ~year, y = ~Unemployemt_rate, type = 'scatter', mode = 'lines+markers',name="Voters Turn out Ratio")
#fig <- fig %>% add_trace(y = ~Republic_Party, name = 'Republic Party', mode = 'lines+markers') 
fig

#Scatter Plot of "Voters turnout ratio  vs Rate of Unemployment"
par(cex= 1,mai=c(0.9,0.9, 0.5, 0.5))
plot(df$Voters.T.R_2016 ~ df$`Unemployment Rate 2015`,data=df,pch=20,
     xlab="Unemployment rate",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Rate of Unemployment")

abline(lm(df$Voters.T.R_2016~df$`Unemployment Rate 2015`, data = df),col="green")

plot(df$Voters.T.R_2012 ~ df$`Unemployment Rate 2011`,data=df,pch=20,
     xlab="Unemployment rate",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Rate of Unemployment")

abline(lm(df$Voters.T.R_2012~df$`Unemployment Rate 2011`, data = df),col="green")

#There has been a decline in unemployment rate from 2011-2015.As from the scater plot the voter turnout ratio decreases as unemployemnt rate increases.Hence there is a strong relation between recession and voters turn out ratio.
#other factos contributing to recession is income,poverty
#income increases,voters turn out ratio increases
#poverty increases,voters turn out ratio decreases
#Scatter Plot of "Voters turnout ratio  vs Per capita income"
par(cex= 1,mai=c(0.9,0.9, 0.5, 0.5))
plot(df$Voters.T.R_2016 ~ df$`Per Capita Income in the Past 12 Months (in 2015 Inflation-Adjusted Dollars)`,data=df,pch=20,
     xlab="Income",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     mmain="Voters turnout ratio  vs Per Capita Income in the Past 12 Months (in 2015 Inflation-Adjusted)")

abline(lm(df$Voters.T.R_2016~df$`Per Capita Income in the Past 12 Months (in 2015 Inflation-Adjusted Dollars)`, data = df),col="green")


#Scatter Plot of "Voters turnout ratio  vs median household income"
par(cex= 1,mai=c(0.9,0.9, 0.5, 0.5))
plot(df$Voters.T.R_2016 ~ df$`Median Household Income 2015`,data=df,pch=20,
     xlab="Income",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Median household income")

abline(lm(df$Voters.T.R_2016~df$`Median Household Income 2015`, data = df),col="green")


#Scatter Plot of "Voters turnout ratio  vs poverty"
par(cex= 1,mai=c(0.9,0.9, 0.5, 0.5))
plot(df$Voters.T.R_2016 ~ df$`Estimated percent of people of all ages in poverty 2015`,data=df,pch=20,
     xlab="Poverty",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Poverty")

abline(lm(df$Voters.T.R_2016~df$`Estimated percent of people of all ages in poverty 2015`, data = df),col="green")


#line graph for total votes received by each party
year<-c("Less than diploma","High school diploma","Associate's degree","Bachelor's degree or higher")
education<-c(mean(df$`Percent of adults with less than a high school diploma, 2011-2015`),mean(df$`Percent of adults with a high school diploma only, 2011-2015`),mean(df$`Percent of adults completing some college or associate's degree, 2011-2015`),mean(df$`Percent of adults with a bachelor's degree or higher, 2011-2015`))
data <- data.frame(year,education)
fig <- plot_ly(data, x = ~year, y = ~education, type = "bar",name="Voters Turn out Ratio")
#fig <- fig %>% add_trace(y = ~Republic_Party, name = 'Republic Party', mode = 'lines+markers') 
fig

year<-c("Less than diploma","High school diploma","Associate's degree","Bachelor's degree or higher")
education<-c(mean(df$`Percent of adults with less than a high school diploma, 2011-2015`),mean(df$`Percent of adults with a high school diploma only, 2011-2015`),mean(df$`Percent of adults completing some college or associate's degree, 2011-2015`),mean(df$`Percent of adults with a bachelor's degree or higher, 2011-2015`))
data <- data.frame(year,education)
fig <- plot_ly(data, y = ~df$`Percent of adults with less than a high school diploma, 2011-2015`, type = "box",name="Less than diploma")
fig <- fig %>% add_trace(y = ~df$`Percent of adults with a high school diploma only, 2011-2015`,  type = "box",name="High school diploma") 
fig <- fig %>% add_trace(y = ~df$`Percent of adults completing some college or associate's degree, 2011-2015`,  type = "box",name="Associate's degree") 
fig <- fig %>% add_trace(y = ~df$`Percent of adults with a bachelor's degree or higher, 2011-2015`,  type = "box",name="Bachelor's degree or higher") 
fig


plot(df$Voters.T.R_2016 ~ df$`Percent of adults with less than a high school diploma, 2011-2015`,data=df,pch=20,
     xlab="Percent of adults with less than a high school diploma, 2011-2015",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Percent of adults with less than a high school diploma, 2011-2015")

abline(lm(df$Voters.T.R_2016~df$`Percent of adults with less than a high school diploma, 2011-2015`, data = df),col="green",lwd=5)


plot(df$Voters.T.R_2016 ~ df$`Percent of adults with a high school diploma only, 2011-2015`,data=df,pch=20,
     xlab="Percent of adults with a high school diploma only, 2011-2015",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Percent of adults with a high school diploma only, 2011-2015")

abline(lm(df$Voters.T.R_2016~df$`Percent of adults with a high school diploma only, 2011-2015`, data = df),col="green",lwd=5)


plot(df$Voters.T.R_2016 ~ df$`Percent of adults completing some college or associate's degree, 2011-2015`,data=df,pch=20,
     xlab="Percent of adults completing some college or associate's degree, 2011-2015",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Percent of adults completing some college or associate's degree, 2011-2015")

abline(lm(df$Voters.T.R_2016~df$`Percent of adults completing some college or associate's degree, 2011-2015`, data = df),col="green",lwd=5)


plot(df$Voters.T.R_2016 ~ df$`Percent of adults with a bachelor's degree or higher, 2011-2015`,data=df,pch=20,
     xlab="Percent of adults with a bachelor's degree or higher, 2011-2015",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Percent of adults with a bachelor's degree or higher, 2011-2015")

abline(lm(df$Voters.T.R_2016~df$`Percent of adults with a bachelor's degree or higher, 2011-2015`, data = df),col="green",lwd=5)

#Voters turn out ratio increases as education qualification increases.Majority of voters has completed high school diploma

#line graph for international migration rate
year<-c("2010-2011","2011-2012","2012-2013","2013-2014","2014-2015")
migration<-c(mean(df$`Net international migration rate in period 7/1/2010 to 6/30/2011`),
             mean(df$`Net international migration rate in period 7/1/2011 to 6/30/2012`),
             mean(df$`Net international migration rate in period 7/1/2012 to 6/30/2013`),
             mean(df$`Net international migration rate in period 7/1/2013 to 6/30/2014`),
             mean(df$`Net international migration rate in period 7/1/2014 to 6/30/2015`))
data <- data.frame(year,migration)
fig <- plot_ly(data, x = ~year, y = ~migration,type="scatter", mode = "lines+markers",name="Voters Turn out Ratio")
#fig <- fig %>% add_trace(y = ~Republic_Party, name = 'Republic Party', mode = 'lines+markers') 
fig


year<-c("2010-2011","2011-2012","2012-2013","2013-2014","2014-2015")
migration<-c(mean(df$`Net international migration rate in period 7/1/2010 to 6/30/2011`),
             mean(df$`Net international migration rate in period 7/1/2011 to 6/30/2012`),
             mean(df$`Net international migration rate in period 7/1/2012 to 6/30/2013`),
             mean(df$`Net international migration rate in period 7/1/2013 to 6/30/2014`),
             mean(df$`Net international migration rate in period 7/1/2014 to 6/30/2015`))
data <- data.frame(year,migration)
fig <- plot_ly(df, y = ~df$`Net international migration rate in period 7/1/2010 to 6/30/2011`, type = "box",name="2010-2011")
fig <- fig %>% add_trace( y = ~df$`Net international migration rate in period 7/1/2011 to 6/30/2012`, type = "box",name="2011-2012")
fig <- fig %>% add_trace( y = ~df$`Net international migration rate in period 7/1/2012 to 6/30/2013`, type = "box",name="2012-2013")
fig <- fig %>% add_trace( y = ~df$`Net international migration rate in period 7/1/2013 to 6/30/2014`, type = "box",name="2013-2014")
fig <- fig %>% add_trace( y = ~df$`Net international migration rate in period 7/1/2014 to 6/30/2015`, type = "box",name="2014-2015")
fig


plot(df$Voters.T.R_2016 ~ df$`Net international migration rate in period 7/1/2014 to 6/30/2015`,data=df,pch=20,
     xlab="Net international migration rate",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Net international migration rate")

abline(lm(df$Voters.T.R_2016~df$`Net international migration rate in period 7/1/2014 to 6/30/2015`, data = df),col="green",lwd=5)

plot(df$Voters.T.R_2012 ~ df$`Net international migration rate in period 7/1/2010 to 6/30/2011`,data=df,pch=20,
     xlab="Net international migration rate",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Net international migration rate")

abline(lm(df$Voters.T.R_2012~df$`Net international migration rate in period 7/1/2010 to 6/30/2011`, data = df),col="green")


#As migration rate increases the voter turn out rate decreases.

total_male=df$`Male: 18 and 19 years 2011 to 2015`+
  df$`Male: 20 years 2011 to 2015`+
  df$`Male: 21 years 2011 to 2015`+
  df$`Male: 22 to 24 years 2011 to 2015`+
  df$`Male: 25 to 29 years 2011 to 2015`+
  df$`Male: 30 to 34 years 2011 to 2015`+
  df$`Male: 35 to 39 years 2011 to 2015`+
  df$`Male: 40 to 44 years 2011 to 2015`+
  df$`Male: 45 to 49 years 2011 to 2015`+
  df$`Male: 50 to 54 years 2011 to 2015`+
  df$`Male: 55 to 59 years 2011 to 2015`+
  df$`Male: 60 and 61 years 2011 to 2015`+
  df$`Male: 62 to 64 years 2011 to 2015`+
  df$`Male: 65 and 66 years 2011 to 2015`+
  df$`Male: 67 to 69 years 2011 to 2015`+
  df$`Male: 70 to 74 years 2011 to 2015`+
  df$`Male: 75 to 79 years 2011 to 2015`+
  df$`Male: 80 to 84 years 2011 to 2015`+
  df$`Male: 85 years and over 2011 to 2015`

df$`percentof male`=(total_male/df$`Total Voting Age Population(2011 -2015)`)*100

total_female=df$`FeFemale: 18 and 19 years 2011 to 2015`+
  df$`Female: 20 years 2011 to 2015`+
  df$`Female: 21 years 2011 to 2015`+
  df$`Female: 22 to 24 years 2011 to 2015`+
  df$`Female: 25 to 29 years 2011 to 2015`+
  df$`Female: 30 to 34 years 2011 to 2015`+
  df$`Female: 35 to 39 years 2011 to 2015`+
  df$`Female: 40 to 44 years 2011 to 2015`+
  df$`Female: 45 to 49 years 2011 to 2015`+
  df$`Female: 50 to 54 years 2011 to 2015`+
  df$`Female: 55 to 59 years 2011 to 2015`+
  df$`Female: 60 and 61 years 2011 to 2015`+
  df$`Female: 62 to 64 years 2011 to 2015`+
  df$`Female: 65 and 66 years 2011 to 2015`+
  df$`Female: 67 to 69 years 2011 to 2015`+
  df$`Female: 70 to 74 years 2011 to 2015`+
  df$`Female: 75 to 79 years 2011 to 2015`+
  df$`Female: 80 to 84 years 2011 to 2015`+
  df$`Female: 85 years and over 2011 to 2015`

df$`percentof female`=(total_female/df$`Total Voting Age Population(2011 -2015)`)*100

plot(df$Voters.T.R_2016 ~ df$`percentof male`,data=df,pch=20,
     xlab="Percentage of male",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Percentage of eligible male voters")

abline(lm(df$Voters.T.R_2016~df$`percentof male`, data = df),col="green",lwd=5)

plot(df$Voters.T.R_2016 ~ df$`percentof male`,data=df,pch=20,
     xlab="Percentage of female",ylab = "Voter's turn out ratio",
     col="DarkBlue",
     main="Voters turnout ratio  vs Percentage of eligible female voters")

abline(lm(df$Voters.T.R_2016~df$`percentof female`, data = df),col="green",lwd=5)

fig <- plot_ly(df, y = ~mean(df$`percentof male`), type = "bar",name="Male")
fig <- fig %>% add_trace( y = ~mean(df$`percentof female`), type = "bar",name="Female")
fig


race=c("White","Black or African American","American Indian and Alaska Native","Asian","Native Hawaiian and Other Pacific Islander","Other race")
population=c(mean(df$`White alone`),mean(df$`Black or African American alone`),mean(df$`American Indian and Alaska Native alone`),mean(df$`Asian alone`),mean(df$`Native Hawaiian and Other Pacific Islander alone`),mean(df$`Some other race alone`))
data <- data.frame(race,population)
fig <- plot_ly(df, y = ~population,x=~race, type = "bar")
fig



#Descriptive Statistics Table
stat_table <- as.data.frame(psych::describe(df))
stat_table <- subset(stat_table, select=c("n","mean","sd","min","max","range")) 
stat_table <- stat_table %>%          
  mutate_if(is.numeric,
            round,
            digits = 1)

#bar graph for total votes obtained over the years
df$Voters.T.R_2016=df$`Total Votes 2016`/df$`Total Voting Age Population(2011 -2015)`
df$Voters.T.R_2012=df$`Total Votes 2012`/df$`Total Voting Age Population(2011 -2015)`


kbl(stat_table) %>%
  kable_styling()

Year<-c("2016","2012","2008")
Percentage_of_Democratic_Votes<-c(round(mean(df$`Percent Demoratic 2016`),digits = 2),round(mean(df$`Percent Demoratic 2012`),digits=2),round(mean(df$`Percent Democratic 2008`),digits = 2))
Percentage_of_Republican_Votes<-c(round(mean(df$`Percent Republican 2016`),digits = 2),round(mean(df$`Percent Republican 2012`),digits=2),round(mean(df$`Percent Republican 2008`),digits=2))
Voters_Turn_Out_Ratio<-c(round(mean(df$Voters.T.R_2016),digits=2),round(mean(df$Voters.T.R_2012),digits=2),"NO DATA")
data <- data.frame(Year, Voters_Turn_Out_Ratio,Percentage_of_Republican_Votes,Percentage_of_Democratic_Votes)

kbl(data) %>%
  kable_styling()


#line graph for total votes received by each party
year<-c("2012","2016")
voters_ratio<-c(mean(df$Voters.T.R_2012),mean(df$Voters.T.R_2016))
data <- data.frame(year,voters_ratio)
fig <- plot_ly(data, x = ~year, y = ~voters_ratio, type = 'scatter', mode = 'lines+markers',name="Voters Turn out Ratio")
#fig <- fig %>% add_trace(y = ~Republic_Party, name = 'Republic Party', mode = 'lines+markers') 
fig

df$PartyWon_2016=ifelse(df$`Percent Demoratic 2016`>df$`Percent Republican 2016`,"Democratic","Republican")
df$PartyWon_2012=ifelse(df$`Percent Demoratic 2012`>df$`Percent Republican 2012`,"Democratic","Republican")
df$PartyWon_2008=ifelse(df$`Percent Democratic 2008`>df$`Percent Republican 2008`,"Democratic","Republican")
df$education=(df$"Percent of adults with a bachelor's degree or higher, 2011-2015"
              #+
              # df$"Percent of adults completing some college or associate's degree, 2011-2015"
              #+df$"Percent of adults with a high school diploma only, 2011-2015")
)#/2
df$race=(df$`White alone`+df$`Black or African American alone`+df$`American Indian and Alaska Native alone`
         +df$`Asian alone`+df$`Native Hawaiian and Other Pacific Islander alone`
         +df$`Some other race alone`)
df$white=(df$`White alone`/df$race)*100
df$black=(df$`Black or African American alone`/df$race)*100
df$other=((df$`American Indian and Alaska Native alone`
           +df$`Asian alone`+df$`Native Hawaiian and Other Pacific Islander alone`
           +df$`Some other race alone`)/df$race)*100



#analysis table


df_2016=df %>%
  group_by(`State Abbreviation`,`County Name`,`Percent Demoratic 2016`, `Percent Republican 2016`,`Voters.T.R_2016`,`Total population 2011 to 2015`,
           `Median Household Income 2015`,`Unemployment Rate 2015`,`Estimated percent of people of all ages in poverty 2015`,
           white,black,other,education,PartyWon_2016,`Total Voting Age Population(2011 -2015)`) %>%
  summarise()%>%
  arrange(`County Name`)


df_2016 %>% 
  group_by(PartyWon_2016) %>% 
  summarize(round(mean(Voters.T.R_2016),digits=2),
            round(mean(`Unemployment Rate 2015`),digits=2),round(mean(`Median Household Income 2015`)),round(mean(`Estimated percent of people of all ages in poverty 2015`),digits=2),
            round(mean(education),digits=2),round(mean(white),digits=2),round(mean(black),digits=2),round(mean(other),digits=2)
            #,round(mean(hispanic),1)
            
  )%>%      
  datatable( colnames = c(" ","Winner","Voters turn out ratio","Unemployment rate","Income","Poverty","Education",
                          "% of White","% of Black","%of other race"),
             class = 'compact', 
             caption = "Average County Demographics by Winner 2016")


fig18 <- plot_ly(df_2016, y = ~education,x=~white,  color = ~PartyWon_2016)
fig18
fig19 <- plot_ly(df_2016, y = ~education,x=~black,  color = ~PartyWon_2016)
fig19

fig19 <- plot_ly(df_2016, y = ~education,x=~other,  color = ~PartyWon_2016)
fig19
fig19 <- plot_ly(df_2016, x=~white,type="box", color = ~PartyWon_2016)
fig19
fig19 <- plot_ly(df_2016, x=~black,type="box", color = ~PartyWon_2016)
fig19
fig19 <- plot_ly(df_2016, x=~other,type="box", color = ~PartyWon_2016)
fig19
#Counties won by democratic has high % of college graduates
#Democratic wins counties across the whiteness spectrum,black other race.
#Republic wins counties where the white population is above 50% and black population is less

fig19 <- plot_ly(df_2016, x = ~education,y=~`Median Household Income 2015`,  color = ~PartyWon_2016)
fig19

#Counties won by democratc has higher education rate compared to republican.They are also prefeered by people irrespective of the income.
#Counties won by republican has lower education rate and lower income compared to democratic.

#poverty vs education
fig19 <- plot_ly(df_2016,y=~df_2016$`Estimated percent of people of all ages in poverty 2015`,x=~df_2016$education, type="scatter", color = ~PartyWon_2016)
fig19

#poverty
fig19 <- plot_ly(df_2016,y=~df_2016$`Estimated percent of people of all ages in poverty 2015`, type="box", color = ~PartyWon_2016)
fig19

#education
fig19 <- plot_ly(df_2016,y=~df_2016$education, type="box", color = ~PartyWon_2016)
fig19

#Democratic won votes from counties where poverty rate is high compared to republican.Democratic are preffered by counties where education rate is high


#poverty vs income
fig19 <- plot_ly(df_2016,y=~df_2016$`Estimated percent of people of all ages in poverty 2015`,x=~df_2016$`Median Household Income 2015`, type="scatter", color = ~PartyWon_2016)
fig19

fig19 <- plot_ly(df_2016,y=~df_2016$`Median Household Income 2015` ,type="box",color = df_2016$PartyWon_2016)
fig19
#Democratic won votes from counties where average income  is hgher compared to republican

#poverty vs race
fig19 <- plot_ly(df_2016,y=~df_2016$`Estimated percent of people of all ages in poverty 2015`,x=~df_2016$white, type="scatter", color = ~PartyWon_2016)
fig19

#Republican won most of the votes from counties where the percentage of white people are more.Democratic won votes irrespective of the race

#poverty and unemployment

fig19 <- plot_ly(df_2016,y=~df_2016$`Unemployment Rate 2015` ,type="box",color = df_2016$PartyWon_2016)
fig19

#unemploymet vs poverty
fig19 <- plot_ly(df_2016,x=~df_2016$`Estimated percent of people of all ages in poverty 2015`,y=~df_2016$`Unemployment Rate 2015`, type="scatter", color = ~PartyWon_2016)
fig19

#unemploymet vs poverty
fig19 <- plot_ly(df_2016,x=~df_2016$`Estimated percent of people of all ages in poverty 2015`,y=~df_2016$`Median Household Income 2015`, type="scatter", color = ~PartyWon_2016)
fig19
fig19 <- plot_ly(df_2016,y=~df_2016$`Median Household Income 2015` ,type="box",color = df_2016$PartyWon_2016)
fig19
#Repuublicans won in counties where povert is less and unemployement is less compared to democratic.
#Unemployyment rate is highest in counties won by democratic

#unemployemnt vs income

fig19 <- plot_ly(df_2016,y=~df_2016$`Unemployment Rate 2015` ,type="box",color = df_2016$PartyWon_2016)
fig19
#Rate of unemployment is high in democratic


#voters_ratio
fig19 <- plot_ly(df_2016,x=~df_2016$`Unemployment Rate 2015`,y=~df_2016$Voters.T.R_2016, type="scatter", color = ~PartyWon_2016)
fig19

fig19 <- plot_ly(df_2016,x=~df_2016$`Median Household Income 2015`,y=~df_2016$Voters.T.R_2016, type="scatter", color = ~PartyWon_2016)
fig19

fig19 <- plot_ly(df_2016,x=~df_2016$`Estimated percent of people of all ages in poverty 2015`,y=~df_2016$Voters.T.R_2016, type="scatter", color = ~PartyWon_2016)
fig19

fig19 <- plot_ly(df_2016,x=~df_2016$education,y=~df_2016$Voters.T.R_2016, type="scatter", color = ~PartyWon_2016)
fig19

fig19 <- plot_ly(df_2016,x=~df_2016$white,y=~df_2016$Voters.T.R_2016, type="scatter", color = ~PartyWon_2016)
fig19



df_2012=df %>%
  group_by(`State Abbreviation`,`County Name`,`Percent Demoratic 2012`, `Percent Republican 2012`,`Voters.T.R_2012`,`Total population 2011 to 2015`,
           `Unemployment Rate 2011`,
           white,black,other,education,PartyWon_2012) %>%
  summarise()%>%
  arrange(`County Name`)



df_2012%>% 
  group_by(PartyWon_2012) %>% 
  summarize(,round(mean(Voters.T.R_2012),digits=2),
            round(mean(`Unemployment Rate 2011`),digits=2),
            round(mean(education),digits=2),round(mean(white),digits=2),round(mean(black),digits=2),round(mean(other),digits=2)
            #,round(mean(hispanic),1)
            
  )%>%      
  datatable( colnames = c(" ","Winner","Voters turn out ratio", "Unemployment rate","Education",
                          "% of White","% of Black","%of other race"),
             class = 'compact', 
             caption = "Average County Demographics by Winner 2012")


as.numeric(df_2016$`Percent Demoratic 2016`)
as.numeric(df_2016$`Percent Republican 2016`)
as.numeric(df_2016$Voters.T.R_2016)
as.numeric(df_2016$`Median Household Income 2015`)
as.numeric(df_2016$`Unemployment Rate 2015`)
as.numeric(df_2016$`Estimated percent of people of all ages in poverty 2015`)
as.numeric(df_2016$white)
as.numeric(df_2016$education)
as.numeric(df_2016$PartyWon_2016)
as.numeric(df_2016$`Total Voting Age Population(2011 -2015)`)
df5=df_2016[-c(1:3,5:6,11:12,14,15)]
names(df5)[4]=c("Percent of poverty_2015")
df6<-select_if(df5, is.numeric)

matrix_format <- cor(df6)
matrix_format
corrplot(matrix_format,tl.cex=0.80)



#make this example reproducible
set.seed(1)

#Use 70% of dataset as training set and remaining 30% as testing set
# Splitting Dataset into train and test sets
df_2016=df_2016[-c(1:6,12)]
df_2016$PartyWon_2016 <-as.factor(df_2016$PartyWon_2016)
trainIndex <- sort(sample(x=nrow(df_2016),size = nrow(df_2016)*0.7))
set.seed(3456)
trainIndex <- createDataPartition(df_2016$PartyWon_2016, p = 0.7, list = FALSE, times = 1)
train <- df_2016[trainIndex,]
test <- df_2016[-trainIndex,]

df_2016$PartyWon_2016 <-as.factor(df_2016$PartyWon_2016)
# Comparision using Viewing the datasets after split
head(train)
head(test)
test$PartyWon_2016 <-as.factor(test$PartyWon_2016)
train$PartyWon_2016 <-as.factor(train$PartyWon_2016)


#model1 <- glm(df5$PartyWon_2016~., family="binomial", data=train)
#summary(model1)

model1 <- glm(PartyWon_2016 ~.,data = train,family = binomial())
summary(model1)

model <- glm(PartyWon_2016~education+white
             +`Unemployment Rate 2015`+`Total Voting Age Population(2011 -2015)`, family="binomial", data=train)
summary(model)

BIC(model)
AIC(model1,model)
pscl::pR2(model1)["McFadden"]
pscl::pR2(model)["McFadden"]

caret::varImp(model)

car::vif(model)



probabilities <- predict(model, newdata = test, type = "response")
predicted.classes.min <- as.factor(ifelse(probabilities>= 0.5 ,"Republican","Democratic"))
## Model Accuracy
model2_CM <-confusionMatrix(predicted.classes.min,test$PartyWon_2016,positive="Republican")
model2_CM


# Metrics of Model 2 Train dataset
cm_tab_values <- as.numeric(model2_CM$table)
TN <- cm_tab_values[1]
FP <- cm_tab_values[2]
FN <- cm_tab_values[3]
TP <- cm_tab_values[4]
## Accuracy of Model 2 Train dataset
print((TN + TP)/(TN + FP+ FN + TP))

## Precision of Model 2 Train dataset
print((TP)/(FP+ TP))

## Recall of Model 2 Train dataset
print((TP)/(FN + TP))

## Specificity of Model 2 Train dataset
print(TN/(TN + FP))


# Plot ROC
ROC_Test <- roc(test$PartyWon_2016, probabilities)


plot(ROC_Test,col="blue",ylab="Sensitivity - TP Rate", xlab="Specificity - FP Rate")

auc <- auc(ROC_Test)
auc


