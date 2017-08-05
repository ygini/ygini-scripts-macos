#!/bin/bash

## Check if we are requested to add the temporary group as member of the local admin group
## And if we aren't, check if the temporary group need to be removed from the local admin group
##
## This payload would be perfect to run in a custom munki check every 30 mins

# Update this variable to fit your needs
TEMPORARY_ADMIN_GROUP="CORP\Agents"
FILE_FLAG_WHEN_TEMPORARY_ADMIN_GROUP_IS_NEEDED="/var/db/com.abelionni.scripts.temporaryadmin"

## Do not change after this line

# Get the temporary group GUID
TEMPORARY_ADMIN_GROUP_GUID=$(dscl /Search read "/Groups/${TEMPORARY_ADMIN_GROUP}" GeneratedUID | awk '{print $2}')

# Check if the temporary group is member of the local admin group

IS_MEMBER_OF_LOCAL_ADMIN_GROUP=$(dscl /Local/Default read /Groups/admin NestedGroups 2> /dev/null | grep "${TEMPORARY_ADMIN_GROUP_GUID}" | wc -l | bc)

# Check if the temporary group must or must not be member of the local admins
MUST_BE_MEMBER_OF_LOCAL_ADMIN_GROUP=0
if [ -f "${FILE_FLAG_WHEN_TEMPORARY_ADMIN_GROUP_IS_NEEDED}" ] 
then
	MUST_BE_MEMBER_OF_LOCAL_ADMIN_GROUP=1
fi

# Fix current state
if [ ${MUST_BE_MEMBER_OF_LOCAL_ADMIN_GROUP} -eq 1 ] && [ ${IS_MEMBER_OF_LOCAL_ADMIN_GROUP} -eq 0 ]
then
	# Add the temporary group as member of the local admin group
	dseditgroup -o edit -a "${TEMPORARY_ADMIN_GROUP}" -t group admin
elif [ ${MUST_BE_MEMBER_OF_LOCAL_ADMIN_GROUP} -eq 0 ] && [ ${IS_MEMBER_OF_LOCAL_ADMIN_GROUP} -eq 1 ]
then
	# Remove the temporary group from the local admin group
	dseditgroup -o edit -d "${TEMPORARY_ADMIN_GROUP}" -t group admin
fi

# If the flag file was here, we need to remove it. So at next run, this script will clear everything
if [ -f "${FILE_FLAG_WHEN_TEMPORARY_ADMIN_GROUP_IS_NEEDED}" ] 
then
	rm "${FILE_FLAG_WHEN_TEMPORARY_ADMIN_GROUP_IS_NEEDED}"
fi

exit 0
