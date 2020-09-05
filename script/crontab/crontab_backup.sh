#!/usr/bin/env bash
# Script initialization
TIME_YYYYMMDD=`date +"%Y%m%d"`;
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )

# Script RUN
/usr/bin/crontab -l > ${SCRIPTPATH}/Crontab_${TIME_YYYYMMDD}.out
/usr/bin/find ${SCRIPTPATH}/* -type f -ctime +7 -name "Crontab_????????.out" -exec rm {} \;
