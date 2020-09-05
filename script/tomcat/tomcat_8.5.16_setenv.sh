#!/bin/bash

# ------------------------------------------------------------
# SET JAVA_HOME
# ------------------------------------------------------------
export JAVA_HOME=/engn001/jdk1.8
JAVA_OPTS=" ${JAVA_OPTS} -server"
JAVA_OPTS=" ${JAVA_OPTS} -DjvmRoute=${SERVER_NAME}_10"
JAVA_OPTS=" ${JAVA_OPTS} -Dwas_cname=${SERVER_NAME}"
JAVA_OPTS=" ${JAVA_OPTS} -Djava.awt.headless=true"
JAVA_OPTS=" ${JAVA_OPTS} -Dfile.encoding=UTF-8"

# ------------------------------------------------------------
# PORT MANAGEMENT
# ------------------------------------------------------------
export INST_PORT=8080

JAVA_OPTS=" ${JAVA_OPTS} -Dport.http=${INST_PORT}"
JAVA_OPTS=" ${JAVA_OPTS} -Dport.https=`expr ${INST_PORT} + 363`"
JAVA_OPTS=" ${JAVA_OPTS} -Dport.ajp=`expr ${INST_PORT} - 71`"
JAVA_OPTS=" ${JAVA_OPTS} -Dport.shutdown=`expr ${INST_PORT} - 75`"

# ------------------------------------------------------------
# SET Garbage Collector
# ------------------------------------------------------------
JAVA_OPTS=" ${JAVA_OPTS} -XX:+UseG1GC"

# ------------------------------------------------------------
# SET Heap Memory
# ------------------------------------------------------------
CATALINA_OPTS=" ${CATALINA_OPTS} -Xms4096m"
CATALINA_OPTS=" ${CATALINA_OPTS} -Xmx4096m"
CATALINA_OPTS=" ${CATALINA_OPTS} -Xss1024k"
#CATALINA_OPTS=" ${CATALINA_OPTS} -XX:NewRatio=2"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:MetaspaceSize=128m"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:MaxMetaspaceSize=256m"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+DisableExplicitGC"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+UseStringDeduplication"

# ------------------------------------------------------------
# SET GC Logging
# ------------------------------------------------------------
CATALINA_OPTS=" ${CATALINA_OPTS} -verbose:gc"
CATALINA_OPTS=" ${CATALINA_OPTS} -Xloggc:${LOG_HOME}/gc_${SERVER_NAME}.log"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+PrintGCDetails"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+PrintGCDateStamps"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"

# ------------------------------------------------------------
# SET SERVER TYPE
# ------------------------------------------------------------
# -Dreport.server.type=prd
# -Dreport.server.type=stg
# -Dreport.server.type=dev
# ------------------------------------------------------------
JAVA_OPTS=" ${JAVA_OPTS} -Dreport.server.type=dev"

# ------------------------------------------------------------
# export variables
# ------------------------------------------------------------
export JAVA_OPTS
export CATALINA_OPTS
