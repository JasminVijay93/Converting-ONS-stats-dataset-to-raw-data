install.packages("readODS")
library(readODS)


dd <-list()
for (x in 3:6) # for taking data from 4 sheets 2019,2018,2017,2016
{
  X2ndDataset <- read_ods("C:\\Users\\jazzj\\Downloads\\DQ\\ras50012.ods" ,sheet =4) 
  #loading data
  newDf <- X2ndDataset[-c(1,2,3,4),] #delete the first 4 rows
  newDf
  headers <- data.frame(region=sapply(newDf,'[[',1))
  region <-headers[complete.cases(headers),]
  newDf <- newDf[-c(1),] #delete the first 4 rows
  newDf <- newDf[-c(95:102),] #delete the last 4 rows
  listofdfs <-newDf[3][1]
  listofdfs <- list() 
  for (i in 1:39) 
    {
      listofdfs[[i]] <- data.frame(c(newDf[i][1]))
 
    }

  listofdfs
  
  df <- as.data.frame(do.call(cbind, listofdfs))
  album2 <- df[, -c(3,4,6,7,9,10,12,13,15,16,18,19,21,22,24,25,27,28,30,31,33,34,36,37,39)] #deleting NA and percentages
  album2 <- album2[-1, ]
  album2 <- head(album2,-5)# deleting data
  album2
  final_df <- data.frame (year ="",region_name="",factors="",CNT="")
  listofdfs <- list() 
  for (i in 1:13)
    {
    if(x==3)
    {final_df <- data.frame(year=c(2019),region_name=c(region[i]),factors=c(album2[1]),CNT=c(album2[i+1]))} #assigning years from different sheets
    else if(x==4)
    {final_df <- data.frame(year=c(2018),region_name=c(region[i]),factors=c(album2[1]),CNT=c(album2[i+1]))}
    else if(x==5)
    {final_df <- data.frame(year=c(2017),region_name=c(region[i]),factors=c(album2[1]),CNT=c(album2[i+1]))}
    else if(x==6)
    {final_df <- data.frame(year=c(2016),region_name=c(region[i]),factors=c(album2[1]),CNT=c(album2[i+1]))}
    names(final_df)[3] <- 'factors'
    names(final_df)[4] <- 'Count'
    
    df2 <- final_df[!(final_df$factors=="Total number of accidents" | final_df$factors=="Road environment contributed" 
                      | final_df$factors=="Vehicle defects"
                      | final_df$factors=="Injudicious action"| final_df$factors=="Driver/Rider error or reaction"
                      | final_df$factors=="Impairment or distraction" | final_df$factors=="Behaviour or inexperience"
                      | final_df$factors=="Vision affected by external factors" | final_df$factors=="Pedestrian only (casualty or uninjured)" 
                      | final_df$factors=="Special Codes"),]
    
    listofdfs[[i]] <- df2
    
  }
  
 

  

  ld <- list() 
  
  for (j in 1:13) #loop for 13 locations
    {
      df<- data.frame(listofdfs[[j]])
      names(df)[3] <- 'Factors'
      names(df)[4] <- 'Count'
      ld[[j]] <- df
  }
  
    dd[[x]] <-ld
  
}


typeof(dd)

dd[[1]] <-NULL
dd[[1]] <-NULL

library(dplyr)
fc <-bind_rows(dd)

library("writexl")
write_xlsx(fc,"C:\\Users\\jazzj\\Downloads\\DQ\\fc.xlsx")












