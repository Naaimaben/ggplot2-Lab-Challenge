#In the following lines of code, we installed the packages we'll need (ggplot2, GGally...) 
dataviz_packages <- c("ggplot2", "GGally", "ggExtra", "ggalluvial", "plotly")
install.packages(dataviz_packages)
library(data.table)
library(readr)
library(ggplot2)
library(data.table)
library(GGally)

#import the dataset region6
getwd()
setwd("/Users/21264/Desktop/Lab 2 on ggplot2")
#read the data using fread
data=fread("region6.csv")
#show some lines of the dataset to verify if the dataset is well imported
dim(data)
head(data)



data[, `:=`
     (math = rowMeans(data[, c(paste0("PV", 1:10, "MATH"))], na.rm = TRUE),
       reading = rowMeans(data[, c(paste0("PV", 1:10, "READ"))], na.rm = TRUE),
       science = rowMeans(data[, c(paste0("PV", 1:10, "SCIE"))], na.rm = TRUE))]




ggplot(data=data,mapping = aes(x=reorder(CNT,science),y=science, fill=region))+
  geom_boxplot()+
  labs(x=NULL, y="Science Scores")+
  #question 2 Using coord_flip() function to flip the coordinates of the plot 
  coord_flip() +
  #question 4 Adding a point into each boxplot to show the mean score by countries.
  stat_summary(fun.y = mean, colour = "blue", geom = "point") +
  #question 5
  geom_hline(yintercept = 493, linetype="dashed", color = "red") +
  

  theme_bw()
#question 3 show the mean value
means <- data[,
              .(science = mean(science)),
              by = CNT]

#7 adding colors to each region
region <- (sapply(data$CNT, function(x) {
  if(x %in% c("Canada", "United States", "Mexico")) "N. America"
  else if (x %in% c("Colombia", "Brazil", "Uruguay")) "S. America"
  else if (x %in% c("Japan", "B-S-J-G (China)", "Korea")) "Asia"
  else if (x %in% c("Germany", "Italy", "France")) "Europe"
  else if (x %in% c("Australia", "New Zealand")) "Australia"
  else if (x %in% c("Israel", "Jordan", "Lebanon")) "Middle-East"
}))

#Exercice 1

ggplot(data=data,mapping = aes(x=reorder(CNT,math),y=math,color=region))+
  geom_point()+
  labs(x = NULL, y="math scores")+
  coord_flip() +
  theme_bw()
ggplot(data=data,mapping = aes(x=reorder(CNT,math),y=math,color=region))+
  geom_violin()+
  labs(x = NULL, y="math scores")+
  coord_flip() +
  theme_bw()
#as a conclusion the first method took much time than the second one


