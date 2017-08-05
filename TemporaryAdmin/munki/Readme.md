# Usage

Use this payload to set a target group as a temporary admins on the local machine.

The main idea is to use a periodic-check setup for munki aside of the regular behavior. Periodic check setup must target a custom manifest with --id option and should be run every 30 mins via launchd.

Using tools like Hello-IT, you can touch the flag file and then trigger your launchd job with a proper script in suid mode.

# Convert the nopkg_scripts content as munki payload

`makepkginfo --nopkg --developer=Abelionni --category="Self-Service" -c testing --autoremove --installcheck_script=installcheck.sh --postinstall_script=postinstall.sh --uninstall_script=uninstall.sh --name="TemporaryAdmins" --displayname="Enable some users to be temporary admins" > TemporaryAdmins-1.0.plist`

# Running in a periodic-check context

The cmd folder contain a script usable with munki periodic.