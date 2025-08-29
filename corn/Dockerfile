FROM alpine:latest
FROM python:3.9-alpine

RUN pip install boto3 awscli
RUN apk add --no-cache mysql-client bash busybox-suid

WORKDIR /app
COPY export.sh /app/export.sh
RUN chmod +x /app/export.sh

# Shared folder for CSVs
VOLUME /data

# Run every 5 minutes (change as needed)
RUN echo "*/3 * * * * /app/export.sh >> /var/log/cron.log 2>&1" > /etc/crontabs/root

CMD ["crond", "-f", "-L", "/dev/stdout"]
