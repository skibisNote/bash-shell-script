#==================================================================================#
# How to Use
#
# - Crontab Syntax and Operators
#    * * * * * command(s)
#    - - - - -
#    | | | | |
#    | | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
#    | | | ------- Month (1 - 12)
#    | | --------- Day of month (1 - 31)
#    | ----------- Hour (0 - 23)
#    ------------- Minute (0 - 59)
#
# - Linux Crontab Command
#  crontab -e   #- Edit crontab file, or create one if it doesn’t already exist.
#  crontab -l   #- Display crontab file contents.
#  crontab -r   #- Remove your current crontab file
#  crontab -i   #- Remove your current crontab file with a prompt before removal
#==================================================================================#
# Environment Variables                                                            #
#==================================================================================#
MAILTO=""
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
