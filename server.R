#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(ggplot2)
library(dplyr)
library(dygraphs)
library(googleVis)
library(ggvis)

shinyServer(function(input, output){

  #Trends for the total death for all years
  output$DeathCountByYear<-renderPlot({
    df %>% group_by (Year) %>% summarise(Total = sum(Deaths, na.rm = TRUE))%>%
    ggplot(data=overview, aes(x=Year, y=Total)) + geom_bar(stat="identity") + 
    labs(title="Total Death Count by Year in NYC")
  })
  
  #Trends for the total death by sex for all years
  output$DeathCountByGender<-renderPlot({
    df %>% group_by(Year, Sex) %>% summarise(Total = sum(Deaths, na.rm = TRUE))%>%
    ggplot(data=by_gender, aes(x=Year, y=Total, fill=Sex)) + 
    geom_bar(position = "dodge", stat="identity") + 
    labs(title="Total Death Count by Gender in NYC")
  })
  
  #Trends for the total death by race for all years
  output$DeathCountByRaceEthnicity<-renderPlot({
    df %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Deaths, na.rm = TRUE)) %>%
    ggplot(data=by_race, aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
    geom_bar(position = "dodge", stat="identity") + 
    labs(title="Total Death Count by Ethnicity in NYC")
  })
  
  #Trends for the total death in males by race for all years
  output$DeathCountInMaleByRaceEthnicity<-renderPlot({
    male_sub <- subset(df, Sex == "Male",select = c("Year","Race.Ethnicity","Sex", "Deaths"))
    male_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Deaths, na.rm = TRUE))%>%
    ggplot(data=by_race_male, aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
    geom_bar(position = "dodge", stat="identity") + 
    labs(title="Total Death Count for Men by Ethnicity in NYC")
  })
  
  #Trends for the total death in females by race for all years
  output$DeathCountInFemaleByRaceEthnicity<-renderPlot({
  female_sub <- subset(df, Sex == "Female",select = c("Year","Race.Ethnicity","Sex", "Deaths"))
  female_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Deaths, na.rm = TRUE))%>%
      ggplot(data=by_race_female, aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
      geom_bar(position = "dodge", stat="identity") + 
      labs(title="Total Death Count for Women by Ethnicity in NYC")
  })
  
  #Trends for death by leading cause
  output$LeadingCauseOfDeath<-renderPlot({
  df %>% group_by(Year, Leading.Cause) %>% summarise(Total = sum(Deaths, na.rm = TRUE))%>%
  ggplot(data=by_cause, aes(x=Year, y=Total, fill=Leading.Cause)) + 
  geom_bar(position = "dodge", stat="identity") + 
  labs(title="Total Death Count by Leading Cause in NYC")
  
  })
  output$LeadingCauseOfDeathByRaceEthnicity<-renderPlot({
  df %>% group_by(Race.Ethnicity, Leading.Cause) %>% summarise(Total = sum(Deaths, na.rm = TRUE))
  %>% ggplot(data=by_cause_race, aes(x=Race.Ethnicity, y=Total, fill=Leading.Cause)) + geom_bar(position = "dodge", stat="identity") + labs(title="Total Death Count by Leading Cause in NYC")
 
  })
  

  #Trend for death by race ethnicity and Leading causes Age Adjusted
  output$DeathCountAgeAdjusted<-renderPlot({
  df %>% group_by(Year, Leading.Cause) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))
  %>% ggplot(data=by_cause_age, aes(x=Year, y=Total, fill=Leading.Cause)) + geom_bar(position = "dodge", stat="identity") + labs(title="Total Age Adjusted Death Count by Leading Cause in NYC")

  })
  
  output$DeathCountAgeAdjustedByRace<-renderPlot({
    df %>% group_by(Race.Ethnicity, Leading.Cause) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))
    %>% ggplot(data=by_cause_race_age, aes(x=Race.Ethnicity, y=Total, fill=Leading.Cause)) + 
      geom_bar(position = "dodge", stat="identity") + 
      labs(title="Total Age Adjusted Death Count by Leading Cause in NYC")
  })
  
  # By Race
    
    output$Top7LeadingDeathInHispanic<-renderPlot({ 
      his_sub <- subset(df, Race.Ethnicity == "Hispanic", select = c("Year","Leading.Cause", "Race.Ethnicity","Sex", "Deaths", "Age.Adjusted.Death.Rate"))
      his_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE)) %>% top_n(n = 7, wt = Total)
      %>% ggplot(cause1, aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Total Death Count")
  })
    
    output$Top7LeadingDeathInAsianandPacificIslanders<-renderPlot({ 
      a_sub <- subset(df, Race.Ethnicity == "Asian and Pacific Islander", select = c("Year","Leading.Cause", "Race.Ethnicity","Sex", "Deaths", "Age.Adjusted.Death.Rate"))
      a_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
      %>% ggplot(cause2, aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Total Death Count")
  })

    output$Top7LeadingDeathinWhitenon-Hispanic<-renderPlot({ 
      w_sub <- subset(df, Race.Ethnicity == "White Non-Hispanic", select = c("Year","Leading.Cause", "Race.Ethnicity","Sex", "Deaths", "Age.Adjusted.Death.Rate"))
      w_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
      %>% ggplot(cause3, aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Total Death Count")
 })
 
    output$Top7LeadingDeathinBlackNon-Hispanic<-renderPlot({ 
      b_sub <- subset(df, Race.Ethnicity == "Black Non-Hispanic", select = c("Year","Leading.Cause", "Race.Ethnicity","Sex", "Deaths", "Age.Adjusted.Death.Rate"))
      b_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
      %>% ggplot(cause4, aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Total Death Count")
 })
    output$Top7LeadingDeathinOther<-renderPlot({  
    o_sub <- subset(df, Race.Ethnicity == "Other Race/ Ethnicity", select = c("Year","Leading.Cause", "Race.Ethnicity","Sex", "Deaths", "Age.Adjusted.Death.Rate"))
    o_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
    %>% ggplot(cause5, aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
    geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Total Death Count")
 })
    
    output$DeathbyHeartDisease<-renderPlot({  
      heart_sub <- subset(df, Leading.Cause == "Diseases o", select = c("Year","Leading.Cause", "Race.Ethnicity","Sex", "Deaths", "Age.Adjusted.Death.Rate"))
      heart_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Deaths, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
      %>% ggplot(data=cause6, aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
      geom_bar(position = "dodge", stat="identity") + 
      labs(title="Total Death Count in Heart Disease by Ethnicity in NYC") + coord_flip()
    })  
    
    output$DeathbyHeartDiseaseAgeAdjusted<-renderPlot({
     cause7= heart_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
     %>% ggplot(data=cause7, aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
     geom_bar(position = "dodge", stat="identity") + 
     labs(title="Total Death Count in Heart Disease by Ethnicity in NYC") + coord_flip()
      
    })
    
    output$DeathbyCancer<-renderPlot({ 
    cancer_sub <- subset(df, Leading.Cause == "Malignant ", select = c("Year","Leading.Cause", "Race.Ethnicity","Sex", "Deaths", "Age.Adjusted.Death.Rate"))
    cancer_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Deaths, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
    %>% ggplot(data=cause8, aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
    geom_bar(position = "dodge", stat="identity") + 
    labs(title="Total Death Count in Heart Disease by Ethnicity in NYC") + coord_flip()
      })
    
    output$DeathbyCancerAgeAdjusted<-renderPlot({ 
    cause9= cancer_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% top_n(n = 7, wt = Total)
    %>% ggplot(data=cause9, aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
    geom_bar(position = "dodge", stat="identity") + 
    labs(title="Total Death Count in Heart Disease by Ethnicity in NYC") + coord_flip()
      
    })
 
}

shinyApp(ui, server)