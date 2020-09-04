library(shiny)
library(plotly)
source("Scripts/filter.R")
my.ui <- navbarPage(
  
  # Application title
  "Gender Inequality Statistics",
  #Writing the report
  tabPanel("Report",
           #Adding information about morocco.
           strong(h2("Morocco"),
                  p("Primary enrollment has improved.Female enrollment has increased rapidly over the years to match the male enrollment in primary schools
                  Improved From 65.9 % to 99.8 to match the male percentage 
                  Primary Completion Rate has also shown a phenonmenal growth to match the male completion rate.
                  Although the Rates for primary completion has increased , not much difference has been observed in Secondary School
                    . Overall Female growth is less than the growth of males."),
                  p("More women were on salary prior to 2001,after 2001 their percentage has dropped from 52.7% to 33.9%
                  Since less women get a regular pay, after 2001 women having vulnerable emplyment has increased from 44.7% to 63.8% while percentage of 
                    males employed in vulnerable employment has marginally decreased.")),
           
           #Adding information about korea.
           strong(h2("Korea"),
                  p("Persistence to grade 5 has increased over the years,the growth has been consistent because more females are 
                    going to secondary schools as well.More than 99% girls are getting secondary education now."),
                  p("The country's policies has been effective in reducing the days required to start a buisness,both men and women can 
                    now start a buisness in just 4 days.Percentage of women having vulnerable employment has also decreased.")),
           
           #Adding information about mexico.
           strong(h2("Mexico"),
                  p("Female enrollment in primary schools has decreased,but suprisingly more females are progressing to the secondary 
                    school.More than 96 women out of 100 that were in primary schools now go to a secondary school."),
                  p("More females have started working overall,out of 100 women working 23 have their own buisnesses,
                    but still out of 100 females working in a job 67 have vulnerable jobs.")),
           
           #Adding information about argentina.
           strong(h2("Argentina"),
                  p("Although the initial values for female enrollment rates in primary schools were similar, 
                    the rate has fluctuated since even though it has slowly caught up again by 2014(male - 99.9, female - 99.5). The gap in lower
                    secondary completion rates between males and females has reduced from a 9% gap in 1970 in favor of females to just a 3% gap in 2014."),
                  p("The females have been a higher percent of the salaried workforce for the past two decades and 
                    have slowly further solidified their lead to 79.9% in 2014 to the male 71.5%. As opposed to most
                    countries, males tend to have higher vulnerability jobs which has remained almost constant over 
                    the past 2 decades while the female percent has reduced.")),
           
           #Adding information about spain.
           strong(h2("Spain"),
                  p("In spain more than 95% of girls who pursue secondary education complete it.Girls have always had a better 
                    completion rate than boys and are still leading by almost 6% ."),
                  p("Even here males own a lot of buisnesses but the gap is much smaller between male and female here
                    .Women employment has seen a rise since 1987 and now has surpassed men.Contrary to other countries 
                     less females are employed in vulnerable jobs.")),
           
           #Adding Information about Colombia.
           strong(h2("Colombia"),
                  p("Primary completion rate has increased for oth girls and boys but the growth for girls is exceptional
                    ,but their is a decrease in girls pursuing secondary education after 2011."),
                  p("There is a increase in females who want to pursue their own buisness, maybe that is the reason their has been 
                    a sharp decline in number of salaried workers.Youth unemployment has marginally increased over the years but
                    is very large as compared to other countries.Many people are have vulnerable employment")),
           
           #Adding Information about Malaysia.
           strong(h2("Malaysia"),
                  p("It has primary enrollment and completion rates , but percentage of girls going for secondary education has
                    decreased.There has been an overall decrease in the secondary completion over the years."),
                  p("More females are now working for a salary.Unemployment rate has been constant,and only 25 out of 100 women 
                    working, have a vulnerable job.")),
           
           #Adding Information about Israel/
           strong(h2("Israel"),
                  p("The country has always had high enrollment and completion rates in both primary and 
                    secondary level education.This has remained fairly constant over the years."),
                  p("Self employment in females has increased,the change is much larger than other countries.
                    Women have always been dominant over men in the employed sector and it is still the same.Moreover,
                    unemployment in females has decreased.")),

             mainPanel(
             )
  ),
  
  #Code for interacive data panel.
  tabPanel("Interactive Data",
           sidebarLayout(
             sidebarPanel(
               #Adding select input to choose from quantities.
               #country is the keyword.
               selectInput('country', "Choose The Country", 
                           choices = list("Morocco" = "MAR",
                                          "Korea" = "KOR",
                                          "Mexico"="MEX",
                                          "Argentina"="ARG",
                                          "Spain"="ESP",
                                          "Colombia"="COL",
                                          "Malaysia"="MYS",
                                          "Israel"="ISR"
                                          
                           )
                   #Adding Slider to select series.        
               ), #series is the key word. 
               
               selectInput("series",
                           "Choose Series",
                           choices=list("Enrollment In Primary School"="SE.PRM.TENR.FE",
                                        "Persistence To Grade 5(%)"="SE.PRM.PRS5.FE.ZS",
                                        "Primary Completion Rate"="SE.PRM.CMPT.FE.ZS",
                                        "Progression To Secondary School"="SE.SEC.PROG.FE.ZS",
                                        "Lower Secondary Completion"="SE.SEC.CMPT.LO.FE.ZS",
                                        "Self Employed"="SL.EMP.OWAC.FE.ZS",                      
                                        "Salaried Workers"="SL.EMP.WORK.FE.ZS",
                                        "Buisness Startup Procedures"="IC.REG.PROC.FE",
                                        "Cost To Start Buisness"="IC.REG.COST.PC.FE.ZS",
                                        "Time Required To Start A Buisness"="IC.REG.DURS.FE",
                                        "Unemployment"="SL.UEM.TOTL.FE.ZS",
                                        "Youth Unemployment Rate"="SL.UEM.1524.FM.ZS",         
                                        "Vulnerable Employment"="SL.EMP.VULN.FE.ZS"))
             ),
             
             
             #Show a plot of the generated distribution
             mainPanel(
               plotlyOutput("country.graph")
             )
           )
  ), 
  #Code for the About Tabpanel
  tabPanel("About",
               strong(h1("Gender Inequality Statistics")),
               p("This website is the final project for INFO 201 at University of Washington. In this project,
                 we obtained gender statistics from WorldBank Dataset.We filtered areas in education and employment
                 that we wanted to highlight, rather wanted to gain information about and made several charts to analyze
                 and visualize various trends in the data. The website itself was made in R with various libraries including DPLYR, 
                 Plotly, and Shiny. We hope that people will be able to use this data to inform themselves 
                 about gender inequality."),
               
               strong(h2("Where is the data from?")),
       
                 paste("The data used for this project was from the World Bank's data hosting platform"),
               a("Data Bank.",href="http://databank.worldbank.org/data/reports.aspx?source=gender-statistics"),
           
              strong(h2("How can the data be used ?")),
              p("The data can be used to see how things have changed in a particular country,we have made sure that 
                the data visuals can be easily used to check the overall change.We have tried to include countries belonging to 
                various contienents and beliefs so that the user can have a holistic view about the data."),
               
               
               strong(h2("Who made the website?")),
               p("Abhijay Kumar , akumar7@uw.edu"),
                p("Emmanuel Munoz , em66@uw.edu"),
                 p("Nalin Gupta , nalin97@uw.edu"),
               mainPanel(
                
               )
  )
)





shinyUI(my.ui)

