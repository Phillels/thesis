library(ggplot)
library(ggplot2)
library(pastecs)
library(fBasics)
install.packages("VGAM")
library(VGAM)

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
#As cocomo increases, vulnerabilities increases (.632)
cor(projectstat$cocomo, projectstat$vulnerabilities)
cor(projectstat$loc, projectstat$vulns)
#.6327
cor(projectstat$loc, projectstat$vulnerabilities)
cor(projectstat$age, projectstat$vulnerabilities)
cor(projectstat$yearcount, projectstat$vulnerabilities)
cor(projectstat$activedevs, projectstat$vulnerabilities)
cor(projectstat$totaldevs, projectstat$vulnerabilities)
cor(projectstat$activedevs, projectstat$vulns)
cor(projectstat$totaldevs, projectstat$vulns)
cor(projectstat$vulnerabilities, projectstat$bd)
cor(projectstat$totaldevs,projectstat$bugcount)
cor(projectstat$loc,projectstat$bugcount)


totaleffort <- (projectstat$cocomo/projectstat$totaldevs)
cor(projectstat$cocomo, projectstat$bugcount)
cor(projectstat$yearcount, projectstat$bugcount)


totaleffort <-(projectstat$totaldevs*projectstat$yearcount)
cor(projectstat$totaleffort, projectstat$vulnerabilities)

hist(bugcount)



plot(projectstat$vulnerabilities)
plot(projectstat$cocomo)

shapiro.test(projectstat$bd)

qqnorm(vulnerabilities, main = 'Normal Probability Plot of Vulnerabilities')
qqnorm(cocomo, main = 'Normal Probability Plot of Cocomo')

effort <-((projectstat$cocomo/projectstat$totaldevs))  
plot(cocomo,vulnerabilities)
abline(lm(vulnerabilities ~ effort), col="red")

lm.out=lm(vulnerabilities~cocomo)
summary(lm.out)

lm.out=lm(vulnerabilities~cocomo+bugcount)
summary(lm.out)


lm.out=lm(vulns~cocomo)
summary(lm.out)

#!!!! r-squared .5331
lm.out=lm(vulnerabilities~loc+totaldevs)
summary(lm.out)

#r-squared .543
lm.out=lm(vulnerabilities~loc+activedevs)
summary(lm.out)

#!!! r-squared .5512
totaleffort <-(projectstat$totaldevs*projectstat$yearcount)
lm.out=lm(vulnerabilities~loc+totaleffort)
summary(lm.out)

options(scipen=999)
#!! r-squared .2965
totaleffort <-(projectstat$totaldevs*projectstat$yearcount)
adjloc <- (projectstat$loc/100000)
lm.out=lm(vulnerabilities~adjloc+totaleffort)
summary(lm.out)

totaleffort <-(projectstat$totaldevs*projectstat$yearcount)
adjloc <- (projectstat$loc/100000)
lm.out=lm(vulns~adjloc+totaleffort)
summary(lm.out)

summary(m<-vglm(vulnerabilities~adjloc+totaleffort, tobit(Lower = 0), data = projectstat ))

sd(projectstat$loc)
mean(projectstat$loc)

totaleffort <-(projectstat$totaldevs*projectstat$yearcount)
sd(projectstat$totaldevs)
mean(projectstat$totaldevs)

sd(projectstat$yearcount)
mean(projectstat$yearcount)

sd(projectstat$vulnerabilities)
mean(projectstat$vulnerabilities)

hist(vulnerabilities)
plot(loc~vulnerabilities)
plot(adjloc~vulnerabilities)
plot(loc~age)

#not significant
totaleffort <-(projectstat$totaldevs*projectstat$yearcount)
lm.out=lm(vulns~totaleffort)
summary(lm.out)

lm.out=lm(vulns~totaleffort)
summary(lm.out)

log.vulnerabilities <-log(vulnerabilities)
hist(log.vulnerabilities)

log.cocomo <-log(cocomo)
hist(log.cocomo)


root.vuln <- (vulnerabilities)^.5
root.cocomo <- (cocomo)^.5


hist(root.vuln)

qqnorm(root.vuln)
qqnorm(root.cocomo)
qplot(trans.fitted, trans.resid) + geom_hline(yintercept = 0)
qplot(trans.fitted, cocomo) + geom_hline(yintercept = 0)




#t test *, positive
lm.out1=lm(vulns~cocomo)
summary(lm.out1)

#t test *, positive
lm.out3=lm(vulns~loc)
summary(lm.out3)

lm.out-(vulns~cocomo+bd+age)
summary(lm.out)


