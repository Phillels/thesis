#!/bin/bash
project,loc,intialcommitdate,recentdate,activedevs,totaldevs,yearcount,totaluniquedevs > /root/Technicaldebt/projectstat.txt 
while read line
do
project=`echo $line|cut -d',' -f1`
urltofetch=`echo $line|cut -d',' -f2`
cd /root/Technicaldebt/project/"$project"/
/root/Technicaldebt/project/cloc-1.66/cloc /root/Technicaldebt/project/"$project"/ --quiet|awk -F' ' '{print $5}' > /root/Technicaldebt/temp.txt

loc=`cat /root/Technicaldebt/temp.txt|grep -v '^$'|tail -1`
intialcommitdate=`git log --date=short|grep '^Date'|awk -F' ' '{print $2}'|tail -1`
recentdate=`git log --date=short|grep '^Date'|awk -F' ' '{print $2}'|head -1`
activedevs=`git log --after="2014-12-31" --before="2016-01-01"|grep 'Author'|awk -F' ' '{print $2}'|sort|uniq|wc -l`
totaldevs=`git log|grep 'Author'|sort|uniq|awk -F' ' '{print $2}'|sort|uniq|wc -l`
`> /root/Technicaldebt/years.tmp`
git log --date=short|grep '^Date'|awk -F' ' '{print $2}'|cut -d'-' -f1|sort|uniq > /root/Technicaldebt/years.tmp
yearcount=`cat /root/Technicaldebt/years.tmp|wc -l`
if [ $yearcount -eq 0 ]
then
echo "No years"
else
totaluniquedevs=0
while read yearinconsideration
do
previouyear=''
previouyear=`expr $yearinconsideration - 1`
afteryear=''
afteryear=`expr $yearinconsideration + 1`
devsinyear=`git log --after=$previouyear-12-31 --before=afteryear-01-01|grep 'Author'|awk -F' ' '{print $2}'|sort|uniq|wc -l`
totaluniquedevs=`expr "$totaluniquedevs" + "$devsinyear"`
done < /root/Technicaldebt/years.tmp
fi
echo $project,$loc,$intialcommitdate,$recentdate,$activedevs,$totaldevs,$yearcount,$totaluniquedevs >> /root/Technicaldebt/projectstat.txt


done < /root/Technicaldebt/project/list.txt
