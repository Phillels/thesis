library(ggplot)
library(ggplot2)
library(pastecs)
library(fBasics)
projectstat <- read.csv("~//Desktop//Technicaldebt//eds-projectstat.csv")

project = projectstat$project
loc = projectstat$loc
initialloc = projectstat$initialcommitdate
recentcommit = projectstat$recentdate
activedevs = projectstat$activedevs
totaldevs= projectstat$totaldevs
yearcount = projectstat$yearcount
age = projectstat$age
bugcount = projectstat$bugcount
vulnerabilities = projectstat$vulnerabilities
bd = projectstat$bd
vulns = projectstat$vulns
cocomo = projectstat$cocomo

colnames(projectstat)[1] <- "project"
colnames(projectstat)[2] <- "loc"
colnames(projectstat)[3] <- "initialcommit"
colnames(projectstat)[4] <- "recentcommit"
colnames(projectstat)[5] <- "activedevs"
colnames(projectstat)[6] <- "totaldevs"
colnames(projectstat)[7] <- "yearcount"
colnames(projectstat)[8] <- "age"
colnames(projectstat)[9] <- "bugcount"
colnames(projectstat)[10] <- "vulnerabilities"
colnames(projectstat)[11] <- "bd"
colnames(projectstat)[12] <- "vulns"
colnames(projectstat)[13] <- "cocomo"

cor(projectstat$bugcount,projectstat$vulnerabilities)
cor(projectstat$bugcount, projectstat$vulns)
cor(projectstat$bd, projectstat$vulns)
cor(projectstat$cocomo, projectstat$vulns)
#As loc increases, vulnerabilities increases (.632)
cor(projectstat$cocomo, projectstat$vulnerabilities)
cor(projectstat$loc, projectstat$vulns)
cor(projectstat$age, projectstat$vulnerabilities)
cor(projectstat$yearcount, projectstat$vulnerabilities)
cor(projectstat$activedevs, projectstat$vulnerabilities)
cor(projectstat$totaldevs, projectstat$vulnerabilities)
cor(projectstat$activedevs, projectstat$vulns)
cor(projectstat$totaldevs, projectstat$vulns)
cor(projectstat$vulnerabilities, projectstat$bd)
cor(projectstat$cocomo, projectstat$bd)

plot(projectstat$vulnerabilities)
plot(projectstat$cocomo)

qqnorm(vulnerabilities, main = 'Normal Probability Plot of Vulnerabilities')
qqnorm(cocomo, main = 'Normal Probability Plot of Cocomo')

effort <-((projectstat$cocomo/projectstat$totaldevs))  
plot(cocomo,vulnerabilities)
abline(lm(vulnerabilities ~ effort), col="red")

lm.out=lm(vulnerabilities~cocomo)
summary(lm.out)

#t test **, positive
lm.out1=lm(vulns~cocomo)
summary(lm.out1)

#t test *, positive
lm.out3=lm(vulns~loc)
summary(lm.out3)

lm.out-(vulns~cocomo+bd+age)
summary(lm.out)


