

library(sqldf)

# create a t test to check if there is difference between average sales before the covid-19
#to the average sales after covid-19
filePath=choose.files() 
table<-read.csv(filePath,header=TRUE)

tTest <- t.test(x=data$before_covid,y=data$after_covid,
                paired = TRUE,var.equal = FALSE,conf.level = 0.95)
print(tTest)

################################################################################
new <- table(table$Province,table$Category) # create a temp table
ftable(new) # create a flat table
summary(new) # do chi test on the table
##########################################################################
filePath=choose.files() 
anov<-read.csv(filePath,header=TRUE)

revenueLost <- anov$Revenue.y1 - anov$Revenue.y3 # get a vector 
# of the values we want to check (if the corona had a impact on revenue)
print(revenueLost)
# create a boxplot for us to see if there is a difference
boxplot(revenueLost~anov$Quarter,data = anov)
# factorize the column so we can create the Anova test
anov$Quarter <- as.factor(anov$Quarter)
# anova test on the impact of the corona on the revenue
anova(lm(revenueLost ~ anov$Quarter,anov))
# we can see that the variance of the revenue before and
# after the corona had changed.

