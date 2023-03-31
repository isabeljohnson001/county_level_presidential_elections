<h1 align="center">County Level Presidential Elections -2008-2016</h1>
The dataset includes county-level Democratic and Republican voter data from the 2008, 2012, and 2016 presidential elections. The dataset contains information about the presidential election voters data for the years 2008,2012,2016. It also includes data on key social and economic factors that may impact the Presidential elections. 
</br>
The dataset can be found under:
</br>
https://dasil.sites.grinnell.edu/downloadable-data/
</br>
</br>
<b>The study aims to address the following questions:-</b>
</br>
<li>What are the factors that influence the voter's participation rate?
</br>
<li>Does economic recession influence the voter's participation rate?
</br>
<li>What social factors influence the voter's behavior in choosing one party over another?
</br>
<h3>Overview of the dataset</h3>
The dataset contains 143 variables that can be summarised into features like state, total votes, total votes acquired by each party, total labor force, unemployment rate, income, poverty, education, migration rate, population, population by age gender, race, and occupation.Data Analysis will include descriptive statistics, correlation analysis, and regression analysis.
<h3>Data Analysis & Visualizations</h3>
<b>Voter turnout ratio</b>
</br>
This is the ratio of the number of people who voted and the total voting population. In this study, the voting population is calculated by adding the number of males and females population aged 18 and above for the years 2011-15. This metric is known as the Voting age population.
</br>

<img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/vtr_emp.png" width="500"/>
<img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/vtr_income.png" width="500"/>
</br>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/vtr_poverty.png" width="500"/>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/vtr_migration.png" width="500"/>
 </br>
<b>US County Demographics by Winner.</b>
</br> 
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/county_wise_winner_2016.png" width="500"/>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/county_wise_winner_2012.png" width="500"/>
 </br>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/unemployment_poverty.png" width="500"/>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/poverty_education.png" width="500"/>
 </br>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/poverty_race.png" width="500"/>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/income_poverty.png" width="500"/>
 </br>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/income_education.png" width="500"/>
 <img src="https://github.com/isabeljohnson001/county_level_presidential_elections/blob/a24907ad70309522f83f00e81acf586a9841699b/race_education.png" width="500"/>
 </br>
 <h3>Insights</h3>
 <p>
 The analysis of the 2008, 2012, and 2016 US Presidential elections provides several insights. The 2008 election had the highest voter turnout. Unemployment rate, household income, poverty, education, and international migration rate all have a significant impact on voter turnout. Counties won by the Republican party generally have lower unemployment rates, higher voter turnout rates, and a larger white population, while counties won by the Democratic party have higher unemployment rates, higher income, and poverty. The analysis also reveals that the Republican party has a positive correlation with the white population and a negative correlation with education. Logistic regression analysis shows that unemployment, white population, education, and total voting age population are important predictors of the PartyWon variable. The area under the curve is 0.9148 which shows the excellent use of the model. These insights can be useful for political campaigns to target specific demographics.
 <h3>Conclusions</h3>
 <p>
 The study aims to address the following questions which were raised in the initial analysis:-
</br>
</br>
<b>What are the factors that influence the voter's participation rate?</b>
</br>
<li>It has been noticed that when the unemployment rate rises, so does the voter turnout ratio. Between 2011 and 2015, the unemployment rate fell by 3%. The voter turnout ratio rose in the 2016 election.
<li>It has been discovered that as household income rises, so does the voter turnout ratio. As a result, higher-income people are more likely to show up to vote.
<li>It has been discovered that as the percentage of poverty increases, so does the voter turnout ratio.
<li>It has been found that when educational qualifications improve from less than high school to completion of a bachelor's degree, the voter turnout ratio increases.
<li>It has been noticed that as the rate of foreign migration rises, so does the voter turnout ratio.
</br>
</br>
<b>Does economic recession influence the voter's participation rate?</b>
</br>
Recession results in an increase in unemployability rates and poverty.
Voters turnout ratio has a negative relative relationship between Unemployment and Poverty. Hence recession influences the voter's participation rate in US presidential elections.
</br>
</br>
<b>What social factors influence the voter's behavior in choosing one party over another?</b>
</br>
<li>Republican-held counties have 89% white residents, a lower unemployment rate, lower education rates, and lower income.
</br>
<li>Democratic-won counties have a higher unemployment rate, higher income, a higher education rate, and a lower poverty rate. People prefer the party regardless of race or income.
</br>
</br>
<b>Unemployment, White, and Education variables were found as important predictors to predict whether the Republican party won or not in US presidential elections.</b>



