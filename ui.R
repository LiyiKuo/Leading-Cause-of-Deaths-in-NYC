#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(dygraphs)
library(gridExtra)
library(rlist)
library(shinydashboard)

df = read.csv("New_York_City_Leading_Causes_of_Death.csv")


shinyUI(dashboardPage(
  
  dashboardHeader(title = "What Kills New Yorkers",titleWidth = 250),
  
  dashboardSidebar(width = 300,
      sidebarMenu(
      menuItem('Overview',tabName = 'Trendline',icon = icon("bar-chart"),
      menuSubItem("Death Count Overview", tabName = "DeathCountbyYear", icon = icon("bar-chart")),
      menuSubItem("Death Count By Gender", tabName = "DeathCountByGender", icon = icon("bar-chart")),
      menuSubItem("Death Count By Race Ethnicity", tabName = "DeathCountByRaceEthnicity", icon = icon("bar-chart")),
      menuSubItem("Leading Cause of Death", tabName = "LeadingCauseOfDeath", icon = icon("bar-chart")),
      menuSubItem("Leading Cause of Death By Race Ethnicity", tabName = "LeadingCauseOfDeathByRaceEthnicity", icon = icon("bar-chart")),
          
#================= Age Adjusted
          
      menuItem("Death Count Age Adjusted", tabName = "DeathCountAgeAdjusted",icon = icon("bar-chart")),
      menuSubItem("Death Count Age Adjusted By Race", tabName = "DeathCountAgeAdjustedByRace", icon = icon("bar-chart")),
        
        
#================== Observing Cause of Deaths by Race and Ethnicity and Gender       
        
  menuItem("Death Ranking By Race Etihnicity", tabName = "DeathRankingByRaceEtihnicity",icon = icon("bubble-chart"),
      menuSubItem("Top 7 Leading Death in Hispanic", tabName = "Top7LeadingDeathInHispanic", icon = icon("bubble-chart")),
      menuSubItem("Top 7 Leading Death in Asian and Pacific Islanders", tabName = "Top7LeadingDeathinAsianandPacificIslanders", icon = icon("bubble-chart"))),
      menuSubItem("Top 7 Leading Death in White non-Hispanic", tabName = "Top7LeadingDeathinWhitenon-Hispanic", icon = icon("bubble-chart"))),
      menuSubItem("Top 7 Leading Death in Black Non-Hispanic", tabName = "Top7LeadingDeathinBlackNon-Hispanic", icon = icon("bubble-chart"))),
      menuSubItem("Top 7 Leading Death in Other", tabName = "Top7LeadingDeathinOther", icon = icon("bubble-chart"))),

#================= By Major Diseases 

     menuItem('Death By Race Ethnicity Comparison',tabName = 'DeathByRaceEthnicityComparison',icon = icon("bar-chart"),
     menuSubItem("Death by Heart Disease", tabName = "DeathbyHeartDisease", icon = icon("bar-chart")),
     menuSubItem("Heart Disease Age Ajusted", tabName = "Heart Disease Age Ajusted", icon = icon("bar-chart")),
     menuSubItem("Death by Cancer", tabName = "DeathbyCancer", icon = icon("bar-chart"))),
     menuSubItem("Death by Cancer Age Adjusted", tabName = "DeathbyCancerAgeAdjusted", icon = icon("bar-chart"))),
          
     menuItem('Conclusion',tabName = "Conclusion",icon = icon("comments-o")),
          
dashboardBody(
  
  menuItem('Overview',tabName = 'Trends',icon = icon("bar-chart"),
           menuSubItem("Death Count Overview", tabName = "DeathCountbyYear", icon = icon("bar-chart")),
           menuSubItem("Death Count By Gender", tabName = "DeathCountByGender", icon = icon("bar-chart")),
           menuSubItem("Death Count By Race Ethnicity", tabName = "DeathCountByRaceEthnicity", icon = icon("bar-chart")),
           menuSubItem("Leading Cause of Death", tabName = "LeadingCauseOfDeath", icon = icon("bar-chart")),
           menuSubItem("Leading Cause of Death By Race Ethnicity", tabName = "LeadingCauseOfDeathByRaceEthnicity", icon = icon("bar-chart")),
           
  
      tabItem(tabName = "Trends",
              fluidRow(column(12,dygraphOutput("Trendline")))),
      tabItem(tabName = "DeathTrendBySex",
              fluidRow(column(12,plotOutput("TrendlineBySex")))),
      
      tabItem(tabName = "TrendLineByRaceEthnicity",
              fluidRow(column(8,plotOutput("TrendLineByRaceEthnicity")),
                       column(4,checkboxGroupInput("Race_Ethnicity",label = h3("Select the race ethnicity"),
                                                   choices = c("Asian and Pacific Islander" = "Asian and Pacific Islander","Black Non-Hispanic" = "Black Non-Hispanic",
                                                               "White Non-Hispanic" = "White Non-Hispanic","Hispanic" = "Hispanic"),selected = "Hispanic",width = 600)))),
      tabItem(tabName = "DeathBySex",
              fluidRow(htmlOutput("DeathBySex"),height=800,width = "100%",
                       selectInput(inputId = "Sex",label = "Choose sex",choices = c("Male" = "M","Female" = "F")))),
      
      
      tabItem(tabName = "DeathByRaceAndSexDensity",
              fluidRow(column(12,plotOutput("DeathByRaceAndSexDensity"),selectInput(inputId = "Sex1",label = "Choose sex",choices = c("All"="All","Male" = "M",
                                                                                                                                      "Female" = "F"))))),
      tabItem(tabName = "TotalDeathByRaceEthnicityBarchart", 
              fluidRow(column(12,plotOutput("TotalDeathByRaceEthnicityBarchart")))),
      tabItem(tabName = "Top5LeadingCauses",
              fluidRow(column(12,plotOutput("Top5LeadingCauses")))),
      tabItem(tabName = "HeartDiseaseandStrokeIndicators",
              h3("Heart Disease and Stroke Mortality"),
              fluidRow(column(12,plotOutput("HeartDiseaseStrokeMortality"))),
              br(),
              h3("Heart Disease and Stroke Hospitalizations"),
              fluidRow(column(12,plotOutput("HeartDiseaseStrokeHospitalizations")))),
      
      tabItem(tabName = "InjuryRelatedIndicators",
              h3("Injury Related Mortality"),
              fluidRow(column(12,plotOutput("InjuryMortality"))),
              br(),
              h3("Injury Related Hospitalizations"),
              fluidRow(column(12,plotOutput("InjuryHospitalizations")))),
      tabItem(tabName = "RespiratoryMortalityIndicators",
              h3("Respiratory Mortality"),
              fluidRow(column(12,plotOutput("RespiratoryMortality"))),
              br(),
              h3("Respiratory Hospitalizations"),
              fluidRow(column(12,plotOutput("RespiratoryHospitalizations")))),
      
      tabItem(tabName = "Conclusion",
              fluidRow(column(12,h1(strong("Conclusion",align = "center",style = "font-family: 'times'; font-si19pt")),
                              p("Looking at the trend from 2007 to 2014, we see in the year of 2008 has the highest death number. What happened in the year of 2008? There is only a slight difference for the total death between 2007 and 2008. Where is the slight increasing coming from? Actually, the majority of deaths are from male.  The major leading causes for the death increasing are Alzheimer's Disease, Chronic Liver Disease and Cirrhosis, Chronic Lower Respiratory Diseases, and Essential Hypertension and Renal Diseases.  The year of 2012 has the least deaths over the period. The decreasing deaths are coming from the male.  The major leading causes for the death drop down is Assault (Homicide), Cerebrovascular Disease (Stroke),  Chronic Lower Respiratory Diseases, Human Immunodeficiency Virus Disease (HIV), Influenza (Flu) and Pneumonia, and Mental and Behavioral Disorders due to Accidental Poisoning and Other Psychoactive Substance Use."),
                              br(),
                              p("The deaths for Asian and Pacific Islander are gradually increasing while Non-Hispanic has a downward trend.  Hispanic deaths are increasing dramatically except there is a drop in 2009. Both male and female deaths dropped about half of deaths comparing with the deaths in 2008.  Black Non-Hispanic deaths decreased dramatically till 2010 and had wiggling sign afterward.  Comparing the trend between race ethnicity, Asian and Pacific Islander has the least deaths and White Non-Hispanic has the highest deaths.  What are the leading causes make the deaths of White Non-Hispanic/Black Non-Hispanic so high?  Heart Diseases is the number one leading cause but there might be different types of heart diseases.  Also, all other causes are ranking number three.  What are all other causes? Perhaps, health indicators might tell the story behind it.  Coronary Heart Disease has high mortality for Black Non-Hispanic and White Non-Hispanic.  Black mortality are slightly higher than white for the heart disease/stroke.  White has a high risk on unintentional injury and elderlies have higher risk to fall.  Black has high risk of Asthma/Chronic Lower Respiratory Hospitalizations.  White has high suicide mortality and black has high drug related hospitalizations.  Black has higher risk in diabetes. Both black and white are at high risk in cancer.  Black has higher birth related mortality."),
                              br(),
                              p("Through the data exploratory data analysis, we conclude that the death trend of females has a significant impact on the overall trend.  The health of females got significant improvement in 2009. Females have more deaths than males and breast cancer is one of the major leading causes of death for females. Black and White have higher health issues/hospitalizations than other races.")
              ))) 
      
      
              )

  

