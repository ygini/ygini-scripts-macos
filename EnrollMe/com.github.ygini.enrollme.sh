#!/bin/bash

while getopts "c" option; do
    case "${option}" in
        c)
            clear_previous_profiles=1
            ;;
    esac
done

if [[ $clear_previous_profiles -eq 1 ]]
then
	/usr/bin/profiles -D
fi

dseditgroup -o checkmember -m "$SUDO_USER" admin
if [[ $? -ne 0 ]]
then
	need_to_update_rights=1
else
	need_to_update_rights=0
fi

if [[ $need_to_update_rights -eq 1 ]]
then
	dseditgroup -o edit -t user -a "$SUDO_USER" admin
fi

os_maj_vers=$(sw_vers -productVersion | awk -F. '{ print $2; }')
os_min_vers=$(sw_vers -productVersion | awk -F. '{ print $3; }')

if [[ $os_maj_vers -ge 13 ]]
then
	/usr/bin/profiles renew -type enrollment
elif [[ $os_maj_vers -eq 12 ]] && [[ $os_min_vers -ge 4 ]]
then
	/usr/bin/profiles -N
elif [[ $os_maj_vers -eq 12 ]]
then
	/usr/libexec/mdmclien dep nag
else
	/usr/libexec/mdmclient cloudconfig
fi

if [[ $need_to_update_rights -eq 1 ]]
then
	dseditgroup -o edit -t user -d "$SUDO_USER" admin
fi

exit 0
