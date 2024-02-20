#Workshop 5 - Tidy Data 1

#2.Philosophy of tidying data 

#Three basic rules for tidy data:
#1. Each row is an observation
#2. Each column is a variable 
#3. Each value has its own cell
#Organizing data in this way ensures that values of different variables from the same observation are always paired

beetles1 <- read.csv("dung_beetles_v1.csv")
beetles1

beetles2 <- read.csv("dung_beetles_v2.csv")
beetles2

beetles3 <- read.csv("dung_beetles_v3.csv")
beetles3

beetles4 <- read.csv("dung_beetles_v4.csv")
beetles4
#Is the most tidy because all the observations are in one row and each column is a variable 

#Count the number of unique sites - to see the importance of keepig work tidy 
usites <- unique(beetles1$Site)
length(usites)
##[1] 5 - site 5 is unique

#Count the number of species from beetles1
colnames(beetles1)[3:ncol(beetles1)]
##[1] "Caccobius_bawangensis"     "Catharsius_dayacus"       
##[3] "Catharsius_renaudpauliani"

#Use unique and length to count the number of species using 'beetles3' - how many beetle species are there?
uspp <- unique(beetles3$spp)
length(uspp)
##[1] 3 - this gives you the number of species. If the 'unique' function was not used it would give the answer 6 - not being specific with species

#Q.which ‘beetles’ table lets you count all unique values for Sites, Months and Species?
#beetles1 - sites and months
#beetles2 - sites and spp
#beetles3 - months and spp
#beetles4 - sites, months, and species

#3.Overview of datasets 
#We can take a look at this data with a number of different functions: 
#str() 
#summary()
#head()
#View()   # <-- this one is in Rstudio only

#Q.Take a look at the 'beetles4' table with these functions
str(beetles4) #Gives you the number of observations and variables
summary(beetles4) #No observations and variables, but it gives you mean. median and interquartile range
head(beetles4) #It is the same as view, but will only give you the first 6 rows by default
View(beetles4)   # <-- this one is in Rstudio only

#4. Reading Tables
#To read in a larger tab;e. we use 'read.table', which is what 'read.csv' does under the hood
beetlesdf <- read.table("dung_beetles_read_1.csv", sep=",",header=T)
beetlesdf
#‘read.table’ is a bit more complex, but a lot more flexible - we had to set the seperator and header, but they are set by default in 'read.csv'

#These two files will not read in with default settings:
read.table("dung_beetles_read_2.txt")
read.table("dung_beetles_read_3.txt")

#fix these lines of code so both files read in correctly
beetlesdf2 <- read.table("dung_beetles_read_2.txt", sep="\t",header=T)  # notice how we set the separator
beetlesdf2
#Because it is a txt not a csv,  we use sep = "\t"

beetlesdf3 <- read.table("dung_beetles_read_3.txt", sep="\t",header=T, skip = 1)# notice how we set the separator
beetlesdf3
#we use the skip to delete the extra text in the first line
#Because it is a txt not a csv,  we use sep = "\t

#4.Fill

install.packages('tidyr')
library(tidyr)

?fill 
fill(beetlesdf, Site)

#If you’re happy with this table, you can overwrite the original table with your fixed version
beetlesdf <- fill(beetlesdf, Site)

#Q.This code should read this file in and fill in the missing values. It does not. Why not?
beetlesdf4 <- read.table("dung_beetles_read_4.txt", sep = "\t", header = T, na.strings = "-")
#Because it does'nt say N/A, using the help function, use na.strings = "-" to set the default back to N/A
fill(beetlesdf4, Site)
beetlesdf4 <- fill(beetlesdf4, Site)  #Overwrite the original table with the fixed version. This will fill in N/A with teh site numbers 

?read.table





