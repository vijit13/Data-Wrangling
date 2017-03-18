
library(dplyr)
library(tidyr)


input<-read.csv("C:\\Users\\Navneet\\Downloads\\titanic_original.csv")

glimpse(input)

#is.na(input$embarked)
input$embarked[which(input$embarked=="")]<-'S'


mean_age<-input %>% summarise(mean=round(mean(age,na.rm=TRUE),digits=2))
typeof(unlist(mean_age))

input$age[is.na(input$age)]<-unlist(mean_age)


input$boat<-as.character(input$boat)
input$boat[which(input$boat=="")]<-'NA'
input$boat<-as.factor(input$boat)
#is.na(input$boat)

input %>% group_by(boat) %>% count(boat)%>%arrange(desc(n))

input$has_cabin_number[which(input$cabin=='')]<-0
input$has_cabin_number[which(!input$cabin=='')]<-1
#%>%mutate(has_cabin_number=ifelse(!is.na(cabin),1,0))


write.csv(input,file='Titanic_clean.csv')

glimpse(input)
