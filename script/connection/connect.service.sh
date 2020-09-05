#!/usr/bin/env bash
# ------------------------------------------------------------
# store options
# ------------------------------------------------------------
HOST_SELECT_OPTIONS=

# ------------------------------------------------------------
# define the configuration file
# ------------------------------------------------------------
SSH_HOST_ENTRIES=service.entries

# ------------------------------------------------------------
# function: print the on-screen menu of connection entries
# ------------------------------------------------------------
print_ssh_host_entry () {
        clear

        echo ""
        echo "# ------------------------------------------------------------"
        echo "# SELECT REMOTE HOST"
        echo "# ------------------------------------------------------------"
        echo "#"

        while read -r line; do
                [[ "$line" =~ ^#.*$ ]] && continue

                if [ ! -z "$line" ]; then
                        option=$(echo "$line" | cut -d":" -f 1)
                        environment=$(echo "$line" | cut -d":" -f 2)
                        descr=$(echo "$line" | cut -d":" -f 3 | sed 's/\"//g')

                        HOST_SELECT_OPTIONS+=("$option")

                        printf "# %3s) %-12s %s\n" "$option" "$environment" "$descr"
                fi

        done < $SSH_HOST_ENTRIES

        echo "#"
        echo "# ------------------------------------------------------------"
        echo ""
}

# ------------------------------------------------------------
# prints host entry
# ------------------------------------------------------------
print_ssh_host_entry

# ------------------------------------------------------------
# waiting for user input
# ------------------------------------------------------------
read -rep "SELECT OPTION: " selection

if [ ! -z "$selection" ] ; then
        for i in "${HOST_SELECT_OPTIONS[@]}"; do
                if [ "$i" == "$selection" ] ; then
                        entry=$(grep ^$selection $SSH_HOST_ENTRIES)

                        connectDescr=$(echo $entry | cut -d":" -f 3)
                        connectUserId=$(echo $entry | cut -d":" -f 4)
                        connectHost=$(echo $entry | cut -d":" -f 5)
                        connectPort=$(echo $entry | cut -d":" -f 6)
                        identityFile=$(echo $entry | cut -d":" -f 7)

                        connectPort=${connectPort:-22}
                        identityFile=`eval echo $identityFile`

                        echo ""
                        echo "connecting to $connectDescr ..."
                        echo ""

                        /usr/bin/ssh -o StrictHostKeyChecking=no -i $identityFile -p $connectPort $connectUserId@$connectHost
                fi
        done
fi

echo ""

exit 0

