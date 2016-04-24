#!/bin/bash
echo project,loc,intialcommitdate,recentdate,activedevs,totaldevs,yearcount,totaluniquedevs > /root/Technicaldebt/projectstat.txt 
while read line; do
  project=`echo $line|cut -d',' -f1`
  urltofetch=`echo $line|cut -d',' -f2`
  cd /root/Technicaldebt/project/"$project"/
  loc=$(/usr/bin/cloc /root/Technicaldebt/project/"$project"/ --quiet| grep SUM | awk -F' ' '{print $5}')
  initialcommitdate=`git log --date=short|grep '^Date'|awk '{print $2}'|tail -1`
  recentdate=`git log --date=short|grep '^Date'|awk '{print $2}'|head -1`
  activedevs=`git log --after="2014-12-31" --before="2016-01-01"|grep 'Author'| perl -ne '/Author:.*<(.*)>/; print $1; print "\n";' |sort|uniq | wc -l`
  totaldevs=`git log | grep 'Author:' | perl -ne '/Author:.*<(.*)>/; print $1; print "\n";' | sort | uniq | wc -l`
  yearcount=$(git log --date=short | grep '^Date' | awk '{print $2}'| awk -F- '{print $1}' | sort | uniq| wc -l)
  echo $project,$loc,$initialcommitdate,$recentdate,$activedevs,$totaldevs,$yearcount >> /root/Technicaldebt/projectstat.txt
done < /root/Technicaldebt/project/projects.csv
