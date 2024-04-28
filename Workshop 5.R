#Workshop 5 - Tidy Data 1

#2.Philosophy of tidying data 

#Three basic rules for tidy data:
#1. Each row is an observation
#2. Each column is a variable 
#3. Each value has its own cell
#Organizing data in this way ensures that values of different variables from the same observation are always paired

beetles1 <- read.csv("dung_beetles_v1.csv")
beetles1
View(beetles1)

beetles2 <- read.csv("dung_beetles_v2.csv")
beetles2
View(beetles2)

beetles3 <- read.csv("dung_beetles_v3.csv")
beetles3
View(beetles3)

beetles4 <- read.csv("dung_beetles_v4.csv")
beetles4
View(beetles4)
#Is the most tidy because all the observations are in one row and each column is a variable 

#Count the number of unique sites - to see the importance of keeping work tidy 
usites <- unique(beetles1$Site)
length(usites)
##[1] 5 - site 5 is unique

#Count the number of species from beetles1
colnames(beetles1)[3:ncol(beetles1)]
##[1] "Caccobius_bawangensis"     "Catharsius_dayacus"
##[3] "Catharsius_renaudpauliani"
#Just no. We should not have to use two different ways to perform the same calculation on different parts of the dataset.

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
#For larger tables R provides you with a range of different functions to get an overview of the data
#We can take a look at this data with a number of different functions: 
#str() 
#summary()
#head()
#View()   # <-- this one is in Rstudio only

#Q.Take a look at the 'beetles4' table with these functions
str(beetles4) #Gives you the number of observations and variables
summary(beetles4) #No observations and variables, but it gives you mean, median, and interquartile range
head(beetles4) #It is the same as view, but will only give you the first 6 rows by default
View(beetles4)   # <-- this one is in Rstudio only

#4. Reading Tables
#To read in a larger table we use 'read.table', which is what 'read.csv' does under the hood
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
#‘beetlesdf’ has a common problem; to aid readability the people generating this table printed each site number only once. This is good for humans, bad for computers. We need to fill these blank spaces with the values above.
#To fox this, a pre-package has been made called 'fill'. which is in the package called 'tidyr'

#Load the library for 'fill', and look at the help package 
install.packages('tidyr')
library(tidyr)

?fill  

#Replace 'data' with your table name, and the '...' with the names of the columns to fill 
fill(beetlesdf, Site)

#If you’re happy with this table, you can overwrite the original table with your fixed version
beetlesdf <- fill(beetlesdf, Site) #careful - this is a common source of errors

#Q.This code should read this file in and fill in the missing values. It does not. Why not?
beetlesdf4 <- read.table("dung_beetles_read_4.txt")
fill(beetlesdf2,Site)

beetlesdf4 <- read.table("dung_beetles_read_4.txt", sep = "\t", header = T, na.strings = "-")
#Because it does'nt say N/A, using the help function, use na.strings = "-" to set the default back to N/A
fill(beetlesdf4, Site)
beetlesdf4 <- fill(beetlesdf4, Site)  #Overwrite the original table with the fixed version. This will fill in N/A with teh site numbers 
View(beetles4)
?read.table

#5.The Pipe 
#Where we have more than one function applied to a table, R has a way to take the output of one function, and shove it straight into the next. This is called piping.
#The symbol we use for a pipe is: '%>%'

df <- read.table("dung_beetles_read_1.csv", sep=",", header=T) %>% fill(Site)
#Notice how the output of both functions is now placed in the variable 'beetlesdf', we will use this more as we start to join these data tidying operations together

#6.Pivoting
#he beetles data set has one of the common problems in untidy data: column headers are values, not variable names. ‘tidyr’ has more functions designed to deal with this issue. Welcome to pivoting.

#pivot_longer
#This will manipulate your table so those column names become variables

?pivot_longer
#It "lengthens" your data, increasing the number of rows and decreasing the number of columns 

pivot_longer(data=beetlesdf, cols = c("Caccobius_bawangensis", "Catharsius_dayacus", "Catharsius_renaudpauliani", "Copis_agnus", "Copis_ramosiceps", "Copis_sinicus", "Microcopis_doriae", "Microcopis_hidakai"),names_to="Spp")
#data - is a data frame to pivot 
#columns - columns to pivot into longer format
#names_to - a character vector specifying the new column stored in the column names of data 

#You will see a change in the table once you assign it to beetlesdf
beetlesdf <- pivot_longer(data=beetlesdf, cols = c("Caccobius_bawangensis", "Catharsius_dayacus", "Catharsius_renaudpauliani", "Copis_agnus", "Copis_ramosiceps", "Copis_sinicus", "Microcopis_doriae", "Microcopis_hidakai"),names_to="Spp")
##It "lengthens" your data, increasing the number of rows and decreasing the number of columns

#Click the link <tidy_select>
#Selecting columns can be done in many ways. If you lick the <tidy_select> link, it will show you the many ways you can select columns, e.g. ‘starts_with()’, ‘ends_with()’, ‘last_col()’

#These can replace your list of columns like this:
beetlesdf <- pivot_longer(data=beetlesdf, cols = starts_with("C") )
#This code is neater, but it’s not selecting all our values is it?

beetlesdf <- pivot_longer(data=beetlesdf, cols = contains('_'), names_to = 'Spp')

#pivot_wider
?pivot_wider

casesdf <- read.table("WMR2022_reported_cases_1.txt",sep="\t")
casesdf

#first, use what you know about ‘read.table’ and ‘fill’ to fix this piece of code:
casesdf <- read.table("WMR2022_reported_cases_1.txt",sep="\t", header=T, na.strings='') %>% fill(country)
View(casesdf)
#Here each row isn't a single observation - instead each country is one observation. 

#So we want to take the values from the methods column, and spread them out as individual columns: the number of columns this makes will depend on the number of unique values in ‘method
#The function we use for this is ‘pivot_wider’
casesdf <- pivot_wider(casesdf,names_from="method",values_from ="n")
#names_from - A pair of arguments describing which column (or columns) to get the name of the output column (names_from)
#values_from - If values_from contains multiple values, the value will be added to the front of the output column

#7. The Big Challenge

#We often have to use many of these functions together. If you look at a larger section of the malaria cases data you’ll see that the full table has the data for all years between 2010 and 2021.
bigdf <- read.table("WMR2022_reported_cases_2.txt",sep="\t", header=T, na.strings = '') %>% fill(country)

#Using the skills you have developed, perform the following steps
#1. Fill empty cells in the country column

#2. Use pivot_longer to move all years into a single column
bigdf <- pivot_longer(bigdf, cols = starts_with('X'), names_to = 'years')

#3. Use pivot_wider move all the method variables into their own column
bigdf <- pivot_wider(bigdf,names_from="method",values_from ="value")

#4. Can you use the pipe function to achieve this in a single command?
casesdf <- read.table("WMR2022_reported_cases_2.txt",
                      sep="\t",
                      header=T,
                      na.strings=c("")) %>% 
  fill(country) %>% 
  pivot_longer(cols=c(3:14),
               names_to="year",
               values_to="cases") %>%
  pivot_wider(names_from = method,
              values_from = cases)
  
  
?pivot_longer



















