Enroll Me
=========

This script is made to be used with [Hello IT](https://www.github.com/ygini/hello-it) and is heavily inspired from [UMAD by Erik Gomez](https://github.com/erikng/umad).

The goal of this script is to trigger the DEP enrollment for an already deployed device with the smallest UI addition possible.

Main idea would be to replace your current Hello IT settings with a single item presenting the red state and asking for enrollment.

The user clicking on the Hello IT item will be admin for few seconds, just the time for macOS to show the enrollment notification.

Once the notification is shown, the user does not need to be admin to continue the process.

Non-DEP scenario isn't supported and providing help text to the user isn't handled. In this scenario, you are supposed to send an e-mail or something to the end users, explaining what they are supposed to do.