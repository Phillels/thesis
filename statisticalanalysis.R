library(ggplot)
Technicaldebt <- read.csv("~/Google Drive/Thesis/Technicaldebt2.csv")
data1=as.data.frame(Technicaldebt$loc)
data2=as.data.frame(Technicaldebt$activedevs)
data3=as.data.frame(Technicaldebt$totaldevs)
data4=as.data.frame(Technicaldebt$yearcount)
data5=as.data.frame(Technicaldebt$totaluniquedevs)
data6=as.data.frame(Technicaldebt$bugcount)

Normalizedloc<-apply(na.omit(data1), MARGIN = 2, FUN = function(X) (na.omit(X) - min(na.omit(X)))/diff(range(na.omit(X))))
Normalizedloc1=as.data.frame(Normalizedloc)
Normalizedactivedevs<-apply(na.omit(data2), MARGIN = 2, FUN = function(X) (na.omit(X) - min(na.omit(X)))/diff(range(na.omit(X))))
Normalizedactivedevs1=as.data.frame(Normalizedactivedevs)
Normalizedtotaldevs<-apply(na.omit(data3), MARGIN = 2, FUN = function(X) (na.omit(X) - min(na.omit(X)))/diff(range(na.omit(X))))
Normalizedtotaldevs1=as.data.frame(Normalizedtotaldevs)
Normalizedyearcount<-apply(na.omit(data4), MARGIN = 2, FUN = function(X) (na.omit(X) - min(na.omit(X)))/diff(range(na.omit(X))))
Normalizedyearcount1=as.data.frame(Normalizedyearcount)
Normalizedtotaluniquedevs<-apply(na.omit(data5), MARGIN = 2, FUN = function(X) (na.omit(X) - min(na.omit(X)))/diff(range(na.omit(X))))
Normalizedtotaluniquedevs1=as.data.frame(Normalizedtotaluniquedevs)
Normalizedbugcount<-apply(na.omit(data6), MARGIN = 2, FUN = function(X) (na.omit(X) - min(na.omit(X)))/diff(range(na.omit(X))))
Normalizedbugcount1=as.data.frame(Normalizedbugcount)

dataf=cbind(Normalizedloc1,Technicaldebt$intialcommitdate,Technicaldebt$recentdate,Normalizedactivedevs1,Normalizedtotaldevs1,Normalizedyearcount1,Normalizedtotaluniquedevs1,data6)

colnames(dataf)[1] <- "loc"
colnames(dataf)[2] <- "intialcommitdate"
colnames(dataf)[3] <- "recentdate"
colnames(dataf)[4] <- "activedevs"
colnames(dataf)[5] <- "totaldevs"
colnames(dataf)[6] <- "yearcount"
colnames(dataf)[7] <- "totaluniquedevs"
colnames(dataf)[8] <- "bugcount"
finaldata=as.data.frame(dataf)
finaldata$Avgdevs=finaldata$totaluniquedevs/finaldata$yearcount

finaldata$totaleffort=finaldata$totaldevs*finaldata$yearcount
finaldata$currenteffort=finaldata$activedevs*finaldata$yearcount
finaldata$avgeffort=finaldata$Avgdevs*finaldata$yearcount


finaldata$cocomo=2.4*(finaldata$loc/1000)^1.05
cor(finaldata$loc,finaldata$totaleffort)
cor(finaldata$loc,finaldata$currenteffort)
#cor(finaldata$loc,finaldata$avgeffort,na.rm = TRUE)
cor(finaldata$yearcount,finaldata$totaleffort)
cor(finaldata$yearcount,finaldata$currenteffort)

cor(finaldata$cocomo,finaldata$totaleffort)
cor(finaldata$cocomo,finaldata$currenteffort)
finaldata$approxdebt=finaldata$cocomo/finaldata$totaldevs

#seq_fit <- lm(approxdebt~loc+activedevs+totaldevs+yearcount+totaluniquedevs+bugcount,data=finaldata)
#step <- stepAIC(seq_fit, direction="both")
# this model is incorrect due to confounding effect of loc on the approxdebt 


#cbind(Normalizedbugcount1,finaldata$approxdebt)
#write.table(Normalizedbugcount1, file = "~/Google Drive/Thesis/normalizedbugcount.csv", sep = ",",qmethod = "double")
#write.table(finaldata$approxdebt, file = "~/Google Drive/Thesis/normalizedeffort.csv", sep = ",",qmethod = "double")
# fixed the file

normalizedbugcount <- read.csv("~/Google Drive/Thesis/normalizedbugcount.csv")
cor(normalizedbugcount$bugcount,normalizedbugcount$effortapprox)

normalizedbugcountmodified <- subset(normalizedbugcount, bugcount <= 0.25)
normalizedbugcountmodified2 <- subset(normalizedbugcountmodified, effortapprox <= 0.025)
cor(normalizedbugcountmodified2$bugcount,normalizedbugcountmodified2$effortapprox)



#t.test(InterlDuplication ~ category, data = subset(Ttestdata,category %in% c('LOW', 'HIGH')), var.equal = TRUE)
wilcox.test(effortapprox ~ category, data = normalizedbugcountmodified2)
wilcox.test(bugcount ~ category, data = normalizedbugcountmodified2)


png(file="~/Google Drive/Thesis/correlation.png",width=400, height=350)
par(mar=c(5,3,2,2)+0.1)
ggplot(normalizedbugcountmodified2, aes(x = bugcount, y = effortapprox)) +
  geom_point(size=1, shape=1) +
  geom_smooth(se = FALSE) +
  labs(title='', x='bugcount', y='Approximate effort') +
  theme_bw()
dev.off()






