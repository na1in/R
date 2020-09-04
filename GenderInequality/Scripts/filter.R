library(dplyr)
library(plotly)

# combine data from both sources
countries.a.l <- read.csv('Data/250e7195-27cb-4e86-a87c-6856a3fa54e9_Data.csv',stringsAsFactors = FALSE)
countries.l.z <- read.csv('Data/eae414b7-55b2-4c9b-b63f-ed07e4a90bc8_Data.csv',stringsAsFactors = FALSE)
countries <- rbind(countries.a.l, countries.l.z)

countries <- mutate(countries, NA_count = rowSums(is.na(countries)))

countries.filtered.48 <- filter(countries, NA_count < 48)
colnames(countries.filtered.48)[1] <- ("Series")

#unique(countries.filtered.48$Series)

# create data frames to highlight good data
countries.filtered.48.summary.by.country <- group_by(countries.filtered.48, Country.Name) %>%
  summarise(count=n())

countries.filtered.48.summary.by.series <- group_by(countries.filtered.48, Series) %>% 
  summarise(count=n())

# create data frame containing only necessary data
countries.filtered.48.edu.employ1.employ2 <- filter(countries.filtered.48, Series.Code == "SE.PRM.TENR.FE" | Series.Code == "SE.PRM.TENR.MA"
                                    | Series.Code == "SE.SEC.CMPT.LO.FE.ZS" | Series.Code == "SE.SEC.CMPT.LO.MA.ZS"
                                    #| Series.Code == "SE.PRM.NINT.FE.ZS" | Series.Code == "SE.PRM.NINT.MA.ZS"
                                    | Series.Code == "SE.PRM.PRS5.FE.ZS" | Series.Code == "SE.PRM.PRS5.MA.ZS"
                                    | Series.Code == "SE.PRM.CMPT.FE.ZS" | Series.Code == "SE.PRM.CMPT.MA.ZS"
                                    | Series.Code == "SE.SEC.PROG.FE.ZS" | Series.Code == "SE.SEC.PROG.MA.ZS"
                                    #| Series.Code == "SE.PRM.CMPL.FE.ZS" | Series.Code == "SE.PRM.CMPL.MA.ZS"
                                    #| Series.Code == "SE.SCH.LIFE.FE" | Series.Code == "SE.SCH.LIFE.MA"
                                    
                                    #| ((Series.Code == "SL.EMP.SELF.FE.ZS" | Series.Code == "SL.EMP.SELF.MA.ZS")&Country.Code == "CAN")
                                    # was meant to filter Canada own-account after having series code changed but Canada already had self-employed
                                    
                                    | Series.Code == "SL.EMP.OWAC.FE.ZS" | Series.Code == "SL.EMP.OWAC.MA.ZS"
                                    | Series.Code == "IC.REG.COST.PC.FE.ZS" | Series.Code == "IC.REG.COST.PC.MA.ZS"
                                    | Series.Code == "IC.REG.PROC.FE" | Series.Code == "IC.REG.PROC.MA"
                                    | Series.Code == "IC.REG.DURS.FE" | Series.Code == "IC.REG.DURS.MA"
                                    
                                    | Series.Code == "SL.EMP.WORK.FE.ZS" | Series.Code == "SL.EMP.WORK.MA.ZS"
                                    #| Series.Code == "SL.EMP.SMGT.FE.ZS" | Series.Code == "SL.EMP.SMGT.MA.ZS"
                                    #| Series.Code == "SL.TLF.TOTL.FE.ZS" | Series.Code == "SL.TLF.TOTL.MA.ZS"
                                    | Series.Code == "SL.UEM.1524.FM.ZS" #| Series.Code == "SL.UEM.1524.MA.ZS"
                                    | Series.Code == "SL.EMP.VULN.FE.ZS" | Series.Code == "SL.EMP.VULN.MA.ZS"
                                    #| Series.Code == "SL.EMP.UNDR.FE.ZS" | Series.Code == "SL.EMP.UNDR.MA.ZS"
                                    | Series.Code == "SL.UEM.TOTL.FE.ZS" | Series.Code == "SL.UEM.TOTL.MA.ZS"
                                    | Series.Code == "SG.GEN.PARL.ZS"
                                    )

countries.filtered.48.edu.employ1.employ2.by.country <- group_by(countries.filtered.48.edu.employ1.employ2, Country.Name) %>% 
  summarise(count=n())

countries.filtered.48.edu.employ.good.data <- filter(countries.filtered.48.edu.employ1.employ2,  
                                          Country.Code == "ARG"
                                        | Country.Code == "MAR"
                                        | Country.Code == "KOR"
                                        | Country.Code == "MEX"
                                        #| Country.Code == "PRY"
                                        | Country.Code == "ESP"
                                        #| Country.Code == "ARE"
                                        #| Country.Code == "ETH"
                                        #| Country.Code == "SWE"
                                        #| Country.Code == "BTN"
                                        | Country.Code == "COL"
                                        #| Country.Code == "BWA"
                                        | Country.Code == "ISR"
                                        #| Country.Code == "GHA"
                                        | Country.Code == "MYS"
                                        #| Country.Code == "CAN"
)

countries.filtered.48.edu.employ.good.by.country <- group_by(countries.filtered.48.edu.employ.good.data, Country.Name) %>% 
  summarise(count=n())

# clean data which represents only ratios
temp <- filter(countries.filtered.48.edu.employ.good.data,Series.Code == 'SL.UEM.1524.FM.ZS')
temp[1:10,36:62] <- temp[1:10,36:62]/(temp[1:10,36:62]+100)*100
temp.2 <- filter(countries.filtered.48.edu.employ.good.data,Series.Code != 'SL.UEM.1524.FM.ZS')
countries.filtered.48.edu.employ.good.data <- rbind(temp,temp.2)
