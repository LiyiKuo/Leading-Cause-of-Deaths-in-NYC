function(input, output) {
  output$Overview <- renderDygraph({
    dygraph(Overview, main ="Death Count vs. Age Adjusted Death Count in NYC", ylab="Total") %>% 
      dySeries("Total", label = "Death Rate") %>% dySeries("Total1", label = "Age Adjusted") %>% dyRangeSelector(height = 20)
  })
  
  output$TotalDeathCountByGender<-renderPlotly({
    ggplotly(df %>% group_by(Year, Sex) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE)) %>%
      ggplot(aes(x=Year, y=Total, fill=Sex)) +
      geom_bar(position = "dodge", stat="identity") +
      labs(title="Total Death Count by Gender in NYC"))
  })
  
  output$TotalDeathCountByRaceEthnicity<-renderPlotly({
    ggplotly(df %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE)) %>%
      ggplot(aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
      geom_bar(position = "dodge", stat="identity") + 
      labs(title="Total Death Count by Ethnicity in NYC"))
  })
  
  output$TotalDeathCountByLeadingCause<-renderPlotly({
    ggplotly(df %>% group_by(Year, Leading.Cause) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE))%>%
      ggplot(aes(x=Year, y=Total, fill=Leading.Cause)) + geom_bar(position = "dodge", stat="identity") + 
      labs(title="Total Death Count by Leading Cause in NYC"))
  })
  
  output$AgeAdjustedLeadingCauseOfDeath<-renderPlotly({
    ggplotly(df %>% group_by(Year, Leading.Cause) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE)) %>%
      ggplot(aes(x=Year, y=Total, fill=Leading.Cause)) + geom_bar(position = "dodge", stat="identity") + 
      labs(title="Total Age Adjusted Death Count by Leading Cause in NYC"))
  })
  
  output$AgeAdjustedLeadingCauseOfDeathByRace<-renderPlotly({
    ggplotly(sub %>% group_by(Race.Ethnicity, Leading.Cause) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE)) %>%
      ggplot(aes(x=Race.Ethnicity, y=Total, fill=Leading.Cause)) + 
      geom_bar(position = "dodge", stat="identity") + 
      labs(title="Total Age Adjusted Death Count by Leading Cause By Race in NYC"))
  })
  
  output$AgeAdjHeartDiseaseData<-renderPlotly({
    ggplotly(heart_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% 
      top_n(n = 7, wt = Total) %>% ggplot(aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
      geom_bar(position = "dodge", stat="identity") + labs(title="Total Death Count in Heart Disease by Ethnicity in NYC") + 
      coord_flip())
  })
  
  output$AgeAdjCancerData<-renderPlotly({
    ggplotly(cancer_sub %>% group_by(Year, Race.Ethnicity) %>% summarise(Total = sum(Age.Adjusted.Death.Rate, na.rm = TRUE))%>% 
      top_n(n = 7, wt = Total) %>% ggplot(aes(x=Year, y=Total, fill=Race.Ethnicity)) + 
      geom_bar(position = "dodge", stat="identity") + labs(title="Total Death Count in Heart Disease by Ethnicity in NYC") + 
      coord_flip())
  })
  
  output$HispanicData<-renderPlotly({
    ggplotly(his_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE)) %>% 
      top_n(n = 7, wt = Total) %>% ggplot(aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Hispanic Leading Cause"))
  })
  
  output$AsianandPacificIslandersData<-renderPlotly({
    ggplotly(a_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE)) %>% 
      top_n(n = 7, wt = Total) %>% ggplot(aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Asian&Pacif-Islanders Leading Cause"))
  })
  
  output$WhiteNonHispanicData<-renderPlotly({
    ggplotly(w_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE)) %>% 
      top_n(n = 7, wt = Total) %>% ggplot(aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="White NonHispanic Leading Cause"))
  })
  
  output$BlackNonHispanicData<-renderPlotly({
    ggplotly(b_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE)) %>% 
      top_n(n = 7, wt = Total) %>% ggplot(aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Black NonHispanic Leading Cause"))
  })
  
  output$OthersData<-renderPlotly({
    ggplotly(o_sub %>% group_by(Year, Leading.Cause, Sex) %>% summarise(Total = sum(Death.Rate, na.rm = TRUE)) %>% 
      top_n(n = 7, wt = Total) %>% ggplot(aes(x=Year, y=Leading.Cause, size=Total, color=Sex)) +
      geom_point(alpha=0.5) + scale_size(range = c(.1, 24), name="Others Leading Cause"))
  })
  
  
  
  
}