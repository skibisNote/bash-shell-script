#!/usr/bin/env bash
# Script initialization
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )

# Script Dynamic Variable
TIME_YYYYMMDDHHMM=`date +"%Y%m%d%H%M"`;
FILE_NAME=${0##*/};

# Script User Variable
CSV_FILE_NAME="NumberOfCount"
SQL="SELECT COUNT(*) FROM sla_statist_uri_data"

# Make
/usr/bin/cp template ${FILE_NAME}_${TIME_YYYYMMDDHHMM}.csv
/usr/bin/mysql -h 'HostName' -P 'Port' -u 'User' -p'PWD' 'DB_NAME' --ssl-mode=DISABLED -e "$SQL"  >> ${FILE_NAME}_${TIME_YYYYMMDDHHMM}.csv
/usr/bin/influx -database 'INFLUX_DB_NAME' -import -path=${FILE_NAME}_${TIME_YYYYMMDDHHMM}.csv

# Script End
exit 0;