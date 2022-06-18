
filePath=choose.files() 
table<-read.csv(filePath,header=TRUE)

Test1 <- t.test(x=table$Quantity,
                      y=table$Amount,alternative = "two.sided",
                      paired = FALSE,var.equal = FALSE,conf.level = 0.95) 
print(Test1)

#Test1 <- t.test(x=table$Amount~table$Quantity,alternative = "two.sided",
#                paired = FALSE,var.equal = FALSE,conf.level = 0.95) 
#print(Test1)

Test2 <- t.test(x=table$Quantity,
                y=table$Amount,alternative = "less",
                paired = FALSE,var.equal = FALSE,conf.level = 0.95) 
print(Test2)
 

################################################################################
new <- table(table$Province,table$Category)
ftable(new)
summary(new)
##########################################################################

filePath=choose.files() 
anov<-read.csv(filePath,header=TRUE)
revenueLost <- anov$Revenue.y1 - anov$Revenue.y3
print(revenueLost)
boxplot(revenueLost~anov$Quarter,data = anov)
anov$Quarter <- as.factor(anov$Quarter)
anova(lm(revenueLost ~ anov$Quarter,anov))


