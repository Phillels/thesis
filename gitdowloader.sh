#!/bin/bash
while read line; do
  project=`echo $line|cut -d',' -f1`
  urltofetch=`echo $line|cut -d',' -f2`
  cd /root/Technicaldebt/project/jme
  `git clone $urltofetch`
done < /root/Technicaldebt/project/projects.csv
