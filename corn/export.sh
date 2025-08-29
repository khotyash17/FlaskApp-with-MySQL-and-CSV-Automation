#!/bin/sh
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
mysql -h db -u root -ppassword --ssl=0 studentsdb -e "SELECT * FROM students;" \
  | sed 's/\t/,/g' > /data/students_$TIMESTAMP.csv
echo "[$(date)] Exported data to /data/students_$TIMESTAMP.csv"
