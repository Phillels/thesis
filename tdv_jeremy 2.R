
library(ggplot2)
library(pastecs)

Technicaldebt <- read.csv("C:\\Users\\Jeremy\\Desktop\\tdv.csv")
attach(Technicaldebt)

loc = Technicaldebt$loc
activeDevs = Technicaldebt$activedevs
totalDevs=Technicaldebt$totaldevs
yearcount=Technicaldebt$yearcount
totaluniquedevs=Technicaldebt$totaluniquedevs
bugcount=Technicaldebt$bugcount
vulnerabilities=Technicaldebt$vulerabilities.in.the.last.10.versions
cocomo=Technicaldebt$cocomo


cor(bugcount,vulnerabilities, method = 'pearson') 
# correlation=.35

cor(finaldata$cocomo,finaldata$vulnerabilities)
#NA
cor(finaldata$activedevs, finaldata$totaldevs)

'Linear Model'
lm.out=lm(vulnerabilities~cocomo)
summary(lm.out)
'Residuals'
lm.resid <- resid(lm.out)
'Fitted Values'
lm.fitted <- fitted(lm.out)

'Normal Probability Plots'
qqnorm(vulnerabilities, main = 'Normal Probability Plot of Vulnerabilities')
qqnorm(cocomo, main = 'Normal Probability Plot of Cocomo')

'Residual Plots - Check for equal variance'
qplot(lm.fitted, lm.resid) + geom_hline(yintercept = 0) 

'----Root Transormation----'
root.vuln <- (vulnerabilities)^.25
root.cocomo <- (cocomo)^.25

'Fitted model after transformation'
log.lm <- lm(root.vuln~root.cocomo)
trans.resid <- resid(log.lm)
trans.fitted <- fitted(log.lm)

'Zero values for vulnerabilities are messing with data, but this looks better'
qqnorm(root.vuln)
qqnorm(root.cocomo)
qplot(trans.fitted, trans.resid) + geom_hline(yintercept = 0)


