#!/bin/sh

###
# This is a sample script demonstrating how recreate the Calendar Server PgSQL UNIX Socket path
###

RunRoot=""			# The base folder for the PgSQL UNIX socket
DataRoot=""			# The base folder for the PgSQL working folder
DatabaseRoot=""			# The name of the PgSQL working folder

DatastoreDirectory=""		# The composition of DataRoot and DatabaseRoot
MD5DatastoreDirectory=""	# The md5 sum of DatastoreDirectory

SocketBaseFolder=""		#The computed base folder for PgSQL UNIX Socket, length limited to 64 char

# Get the RunRoot from the server settings
RunRoot=$(/usr/libexec/PlistBuddy -c 'print RunRoot' /Library/Server/Calendar\ and\ Contacts/Config/caldavd-system.plist 2>/dev/null)

# If empty, get the RunRoot from the default settings
if [ -z "$RunRoot" ]; 
then
	RunRoot=$(/usr/libexec/PlistBuddy -c 'print RunRoot' /Applications/Server.app/Contents/ServerRoot/private/etc/caldavd/caldavd-apple.plist 2>/dev/null)
fi


# Get the DataRoot from serveradmin
DataRoot=$(serveradmin settings calendar:DataRoot | awk 'BEGIN { FS = " = " } ; { print $2 }' | tr -d "\"")


# Get the DatabaseRoot from the server settings
DatabaseRoot=$(/usr/libexec/PlistBuddy -c 'print DatabaseRoot' /Library/Server/Calendar\ and\ Contacts/Config/caldavd-system.plist 2>/dev/null)

# If empty, get the DatabaseRoot from the default settings
if [ -z "$DatabaseRoot" ]; 
then
	DatabaseRoot=$(/usr/libexec/PlistBuddy -c 'print DatabaseRoot' /Applications/Server.app/Contents/ServerRoot/private/etc/caldavd/caldavd-apple.plist 2>/dev/null)
fi


DatastoreDirectory="$DataRoot/$DatabaseRoot"
MD5DatastoreDirectory=$(md5 -s "$DatastoreDirectory" | awk 'BEGIN { FS = " = " } ; { print $2 }' | tr -d "\"")

SocketBaseFolder="$RunRoot/ccs_postgres_$MD5DatastoreDirectory/"

if [ "$(echo ${#SocketBaseFolder})" -gt 64 ];
then
	SocketBaseFolder="/tmp/ccs_postgres_$MD5DatastoreDirectory/"
fi

echo $SocketBaseFolder

exit 0
