
library(dplyr)
library(tidyr)


input<-read.csv("C:\\Users\\Navneet\\Downloads\\refine.csv")

input

input$company<-tolower(input$company)
input$company<-gsub(" ","",input$company)


input<- input%>% mutate(company=ifelse(grepl('^phi|^fi|^phl',company),'philips',company))%>%
                  mutate(company=ifelse(grepl('^ak',company),'akzo',company)) %>%
                     mutate(company=ifelse(grepl('^van',company),'van houten',company)) %>%
                         mutate(company=ifelse(grepl('^uni',company),'Unilever',company))
input

refine_clean<-input%>% separate(Product.code,c("product_code", "product_number"))
refine_clean

refine_clean%>%filter(product_code=='p')%>%mutate(product_category='Smartphone')


refine_clean<-refine_clean%>%mutate(product_category=ifelse(product_code=='p','Smartphone',
                     ifelse(product_code=='v','TV',ifelse(product_code=='x','Laptop',
                      ifelse(product_code=='q','Tablet','NA')))))
refine_clean

#refine_clean$full_address<-paste(refine_clean$address,refine_clean$city,refine_clean$country,sep=',')
#refine_clean

refine_clean<-refine_clean%>%unite(full_address,address,city,country,sep=',')
refine_clean

refine_clean$company_philips[refine_clean$company=='philips']<-1
refine_clean$company_akzo[refine_clean$company=='akzo']<-1
refine_clean$company_van_houten[refine_clean$company=='van houten']<-1
refine_clean$company_unilever[refine_clean$company=='unilever']<-1


refine_clean$product_smartphone[refine_clean$product_category=='Smartphone']<-1
refine_clean$product_tv[refine_clean$product_category=='TV']<-1
refine_clean$product_laptop[refine_clean$product_category=='Laptop']<-1
refine_clean$product_tablet[refine_clean$product_category=='Tablet']<-1


refine_clean[is.na(refine_clean)]<-0
refine_clean

write.csv(refine_clean,file="refine_clean.csv")
