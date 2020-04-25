fluidPage(
  dashboardPage(
    skin = "black",
 
    dashboardHeader(
      title = "What Kills New Yorkers?", titleWidth = 250
    ),
    dashboardSidebar(width = 300,
                     sidebarMenu(
                       #uiOutput("Year"),
                       menuItem('Introduction',tabName = 'Introduction',icon = icon("comments-o")),
                       menuItem('Trends',tabName = 'Trends',icon = icon("line-chart"),
                                menuSubItem("Overview", tabName = "Overview", icon = icon("line-chart")),
                                menuSubItem("Total Death Count By Gender", tabName = "TotalDeathCountByGender", icon = icon("bar-chart")),
                                menuSubItem("Total Death Count By Race Ethnicity", tabName = "TotalDeathCountByRaceEthnicity", icon = icon("bar-chart")),
                                menuSubItem("Total Death Count By Leading Cause", tabName = "TotalDeathCountByLeadingCause", icon = icon("bar-chart")),
                                
                                menuItem('Age Adjusted Data',tabName = 'Age Adjusted Data',icon = icon("line-chart"),
                                         menuSubItem("Age Adj Leading Cause", tabName = "AgeAdjustedLeadingCauseOfDeath", icon = icon("bar-chart")),
                                         menuSubItem("Age Adj Death By Race", tabName = "AgeAdjustedLeadingCauseOfDeathByRace", icon = icon("bar-chart")),
                                         menuSubItem("Age Adj Heart Disease Data", tabName = "AgeAdjHeartDiseaseData", icon = icon("bar-chart")),
                                         menuSubItem("Age Adj Cancer Data", tabName = "AgeAdjCancerData", icon = icon("bar-chart"))
                                         )),
                       
                       menuItem('Closer Look',tabName = 'CloserLook',icon = icon("line-chart"),
                                menuSubItem("Hispanic Data", tabName = "HispanicData", icon = icon("bar-chart")),
                                menuSubItem("Asian and Pacific Islanders Data", tabName = "AsianandPacificIslandersData", icon = icon("bar-chart")),
                                menuSubItem("White Non Hispanic Data", tabName = "WhiteNonHispanicData", icon = icon("bar-chart")),
                                menuSubItem("Black Non Hispanic Data", tabName = "BlackNonHispanicData", icon = icon("bar-chart")),
                                menuSubItem("Others Data", tabName = "OthersData", icon = icon("bar-chart"))),
                       menuItem('Conclusion',tabName = "Conclusion",icon = icon("comments-o"))
                     )
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = "Introduction", 
                fluidRow(img(src="https://www.plazzart.com/doc/plot/images/lots/20190731_mdv_232/snowbombred-12-2015.jpg", height = 500, width = 900, align = "center")),
                br(),
                fluidRow(box(p("Leading causes of death by sex and ethnicity in New York City from 2007-2014. 
                             Based on NYC death certificate issued for every death that occurs in New York City."), width = 600)),
                fluidRow(box(p("Rates based on small numbers (RSE > 30) as well as aggregate counts less than 
                               5 have been suppressed in downloaded data"), width = 600)),
                fluidRow(box("Source: Bureau of Vital Statistics and New York City Department of Health and Mental Hygiene. 
                             (Report last ran: 09/24/2019)", width = 600))),
                
      
        tabItem(tabName = "Overview", fluidRow(dygraphOutput("Overview"))),
        tabItem(tabName = "TotalDeathCountByGender", fluidRow(plotOutput("TotalDeathCountByGender"))),
        tabItem(tabName = "TotalDeathCountByRaceEthnicity", fluidRow(plotOutput("TotalDeathCountByRaceEthnicity"))),
        tabItem(tabName = "TotalDeathCountByLeadingCause", fluidRow(plotOutput("TotalDeathCountByLeadingCause"))),
        
        tabItem(tabName = "AgeAdjustedLeadingCauseOfDeath", fluidRow(plotOutput("AgeAdjustedLeadingCauseOfDeath"))),
        tabItem(tabName = "AgeAdjustedLeadingCauseOfDeathByRace", fluidRow(plotOutput("AgeAdjustedLeadingCauseOfDeathByRace"))),
        tabItem(tabName = "AgeAdjHeartDiseaseData", fluidRow(plotOutput("AgeAdjHeartDiseaseData"))),
        tabItem(tabName = "AgeAdjCancerData", fluidRow(plotOutput("AgeAdjCancerData"))),
        
        tabItem(tabName = "HispanicData", fluidRow(plotlyOutput("HispanicData", width = "600px", height = "500px"))),
        tabItem(tabName = "AsianandPacificIslandersData", fluidRow(plotlyOutput("AsianandPacificIslandersData", width = "600px", height = "500px"))),
        tabItem(tabName = "WhiteNonHispanicData", fluidRow(plotlyOutput("WhiteNonHispanicData", width = "600px", height = "500px"))),
        tabItem(tabName = "BlackNonHispanicData", fluidRow(plotlyOutput("BlackNonHispanicData", width = "600px", height = "500px"))),
        tabItem(tabName = "OthersData", fluidRow(plotlyOutput("OthersData", width = "600px", height = "500px"))),
        
        tabItem(tabName = "Conclusion",
                fluidRow(h4("Conclusion:")),
                fluidRow(box(p("Overall, the top 5 leading causes of deaths in New York City amongst all gender and ethnicity groups are Heart Diseases, 
                                Malignant Neoplasms, Influenza and Pneumonia, Diabetes Mellitus, Cerebrovascular Disease. Some causes [Mental and Behavioral 
                                Disorders due to Accidental Poisoning and Other Psychoactive Substance Use, Human Immunodeficiency Virus Disease, Intentional Self-Harm,
                                Nephritis, Nephrotic Syndrome and Nephrosis, Essential Hypertension, Assult, and Renal Diseases] have noticible higher prevalence in 
                                specific race(s)/ethnicity(ies) but not others. Female in general has higher susceptibility to death related to Alzheimer's 
                                Disease and Septicemia than male"), width = 600, align = "left"))
        
                
                )
      ))))

