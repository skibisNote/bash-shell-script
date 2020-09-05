#!/usr/bin/env bash
# ------------------------------------------------------------
# set environment variables
# ------------------------------------------------------------
TMP_TOMCAT_LISTEN_PORT=8080

# ------------------------------------------------------------
# retrieve IP address on eth0 interface
# ------------------------------------------------------------
TMP_HOST_IP_ADDRESS=`/sbin/ip -4 addr show eth0 | awk '/inet/{print $2}' | cut -f1 -d'/'`

# ------------------------------------------------------------
# check process status
# ------------------------------------------------------------
echo ""
echo "# ============================================================"
echo "# checking Tomcat listening port"
echo "# ============================================================"
echo "#"
TMP_CHK_RESULT=`/usr/sbin/lsof -i -P -n | grep [L]ISTEN | grep [:]${TMP_TOMCAT_LISTEN_PORT}`

if [[ -z "${TMP_CHK_RESULT}" ]]; then
        echo "# STATUS = [STOPPED]"
        echo "# HOST   = $(uname -n) / ${TMP_HOST_IP_ADDRESS}"
        echo "# PORT   = ${TMP_TOMCAT_LISTEN_PORT}"
        echo "# MSG    = Tomcat is not running"
else
        echo "# STATUS  = [RUNNING]"
        echo "# HOST    = $(uname -n) / ${TMP_HOST_IP_ADDRESS}"
        echo "# USER    = $(echo ${TMP_CHK_RESULT} | awk '{print $3}')"
        echo "# PID     = $(echo ${TMP_CHK_RESULT} | awk '{print $2}')"
        echo "# COMMAND = $(echo ${TMP_CHK_RESULT} | awk '{print $1}')"
        echo "# PORT    = ${TMP_TOMCAT_LISTEN_PORT}"
fi
echo "#"
echo "# ------------------------------------------------------------"
echo ""
