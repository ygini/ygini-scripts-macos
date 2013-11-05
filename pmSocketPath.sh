#!/bin/sh

###
# This is a sample script demonstrating howto get the Profile Manager PgSQL UNIX Socket path
###

# Since /Library/Server/ProfileManager/Config/PostgreSQL_config.plist is hardcoded in /Applications/Server.app/Contents/ServerRoot/System/Library/LaunchDaemons/com.apple.DeviceManagement.postgres.plist, I think it's OK to hardcode too...

/usr/libexec/PlistBuddy -c print /Library/Server/ProfileManager/Config/PostgreSQL_config.plist | grep unix_socket_directory | awk 'BEGIN { FS = "=" } ; { print $2 }' | tr -d "\""

exit 0
