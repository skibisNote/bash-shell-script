#!/usr/bin/env bash
# Script initialization
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )

TIME_YYYYMMDDHH=`date +"%Y%m%d%H"`;
FILE_NAME=${0##*/};

# Make CSV File
BEGIN_TIME=`date +"%s%N"`;

SQL="SELECT COUNT(*) FROM device_stat";
ROW_NUM=(`/usr/bin/mysql -h HOST -P PORT -u USER -pPWD DB_NAME --ssl-mode=DISABLED -e "$SQL"`)
SPACE_VALUE=100000;

for (( i=0; i<${ROW_NUM[1]}; i=i+${SPACE_VALUE} ))
 do
  SQL="SELECT DEVICE_ID FROM device_stat LIMIT ${i},${SPACE_VALUE}";

  if [ ${i} -eq 0 ];
  then
   /usr/bin/mysql -h HOST -P PORT -u USER -pPWD DB_NAME --ssl-mode=DISABLED -e "$SQL" | sed "s/'/\'/g;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" > DEVICE_STAT_${TIME_YYYYMMDDHH}.csv
  else
   /usr/bin/mysql -sN -h HOST -P PORT -u USER -pPWD DB_NAME --ssl-mode=DISABLED -e "$SQL" | sed "s/'/\'/g;s/\t/\",\"/g;s/^/\"/;s/$/\"/;s/\n//g" >> DEVICE_STAT_${TIME_YYYYMMDDHH}.csv
  fi
done

END_TIME=`date +"%s%N"`; ELAPSED=`echo "($END_TIME - $BEGIN_TIME) / 1000000" | bc`; ELAPSEDSEC=`echo "scale=6;$ELAPSED / 1000" | bc | awk '{printf "%.6f", $1}'`;
printf "%-20s %-45s %-3s %-4.6f %-3s\n" `date +'%Y-%m-%d(%H:%M:%S)'` ${FILE_NAME} $SERVER_REGION_NAME $ELAPSEDSEC sec >> ${TIME_YYYYMMDD}.log;

# Script End                                                            #
exit 0;
