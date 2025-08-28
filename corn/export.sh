#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
OUTPUT_FILE="/data/students_$TIMESTAMP.csv"

mysql -h db -u root -p password studentsdb -e "SELECT * FROM students" \
  --batch --skip-column-names | sed 's/\t/,/g' > $OUTPUT_FILE

echo "[$(date)] Exported data to $OUTPUT_FILE"
