#!/bin/sh
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

FILE="/data/students_$TIMESTAMP.csv"

# Export mysql data to CSV
mysql -h db -u root -ppassword --ssl=0 studentsdb -e "SELECT * FROM students;" \
  | sed 's/\t/,/g' > "$FILE"
echo "[$(date)] Exported data to $FILE"

# Upload to S3
aws s3 cp "$FILE" s3://students-reg-csv/

echo "Uploaded $FILE to S3"
