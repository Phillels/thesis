library(ggplot2)

techData <- read.csv("~//Desktop//eds.csv")

'Attach data frame for easy references'
attach(techData)

'Creating dummy variable for vulnerabilities'
techData$hasVuln <- as.factor(techData$vulnerabilities > 0)

'Date columns needs to be converted from factor to date type'
str(techData)
techData$startDate <- as.Date(techData$intialcommitdate, format = "%m/%d/%Y")
techData$endDate <- as.Date(techData$recentdate, format = "%m/%d/%Y")

'Messy plot of lines of code of projects'
ggplot(techData, aes(x = startDate,y = sqrt(cocomo), color = hasVuln)) + 
  geom_line() +
  geom_point() +
  scale_x_date() + 
  xlab("") + 
  ylab("Lines of Code") +
  ggtitle("Lines of Code of Projects Over Time")

detach(techData)

'Data for correlation between total devs and bug count with no outliers'
MoPeopleMoProblems <- subset(techData, bugcount >= 0 & bugcount < 2000 & totaldevs < 5000)
cor(MoPeopleMoProblems$bugcount, MoPeopleMoProblems$totaldevs) 
attach(MoPeopleMoProblems)

'Linear model'
fit <- lm(bugcount~totaldevs, MoPeopleMoProblems)

'Scatter plot with with regression line and confidence bands'
ggplot(MoPeopleMoProblems, aes(x = totaldevs,y = bugcount)) + 
  geom_point() +
  geom_smooth(method = 'lm', se = TRUE) +
  xlab("Number of Developers") + 
  ylab("Bugs") +
  ggtitle("Mo' People = Mo' Problems")