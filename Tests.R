
filePath=choose.files() 
table<-read.csv(filePath,header=TRUE)

# create a t test to check if there is effect from quantity
# on the amount of revenue

Test1 <- t.test(x=table$Quantity,
                      y=table$Amount,alternative = "two.sided",
                      paired = FALSE,var.equal = FALSE,conf.level = 0.95) 
print(Test1)

#Test1 <- t.test(x=table$Amount~table$Quantity,alternative = "two.sided",
#                paired = FALSE,var.equal = FALSE,conf.level = 0.95) 
#print(Test1)
# create a t test for a negative effect from quantity on the amount of revenue
Test2 <- t.test(x=table$Quantity,
                y=table$Amount,alternative = "less",
                paired = FALSE,var.equal = FALSE,conf.level = 0.95) 
print(Test2)
 

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

