#!/usr/bin/env bash
# initialization
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P )

# PID
PID_FILE="v5.pid";
if [ -e "${PID_FILE}" ];
then
 exit 1;
else
 echo $$ > ${PID_FILE}
fi

# Java
JAVA_OPTS="-Dfile.encoding=UTF-8"
JAVA_OPTS="${JAVA_OPTS} -XX:+UseG1GC"
JAVA_OPTS="${JAVA_OPTS} -Xms4096m -Xmx4096m"
JAVA_OPTS="${JAVA_OPTS} -Xss1024k"
JAVA_OPTS="${JAVA_OPTS} -XX:MetaspaceSize=128m"
JAVA_OPTS="${JAVA_OPTS} -XX:MaxMetaspaceSize=256m"
JAVA_OPTS="${JAVA_OPTS} -XX:+DisableExplicitGC"
JAVA_OPTS="${JAVA_OPTS} -XX:+UseStringDeduplication"

# FileName
JAR_FILE="v5.jar"

# Export
export JAVA_HOME=/engn001/jdk1.8
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib
export JAVA_OPTS=${JAVA_OPTS}

# Check
PROCESS_CNT=$(/usr/bin/ps -ef | grep [j]ava | grep ${JAR_FILE} | wc -l)
if [ $PROCESS_CNT -gt 0 ]; then exit 1; fi

# Run
${JAVA_HOME}/bin/java ${JAVA_OPTS} -cp ${CLASSPATH} -jar ${SCRIPTPATH}/${JAR_FILE}

# End
rm ${PID_FILE}
exit 0;
