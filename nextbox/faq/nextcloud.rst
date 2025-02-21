Nextcloud FAQ
=============

**Q:** What to do to run/install/fix Nextcloud App "XYZ"? Why does Nextcloud feature XYZ not work?
  Generally we cannot help in detail for these topics. Nextcloud internals and apps are 
  out-of-scope for the NextBox development as we use the stock Docker images provided by Nextcloud.
  Ultimately, if some NextBox/OS configuration is blocking an app to run properly we for sure will
  look into fixing it.

**Q:** Why does Nitrokey currently not recommend to use OnlyOffice or Collabora Office on the NextBox?
  The state of these Nextcloud apps is not yet mature (for ARM platforms). Although it is (partly)
  possible to install them we do not recommend doing so currently.

**Q:** Why does updating Nextcloud from inside Nextcloud not work?
  The Nextcloud version is rolled out by us. Thus the option to update from inside Nextcloud
  is not working. 

**Q:** Can I add apps to the Nextcloud instance?
  Yes, the Nextcloud app store is available and any app available there can be installed through
  the Nextcloud web frontend.

**Q:** My Nextcloud instance is stuck in "Maintenance Mode", how can I switch it off?
  To *force exit* the Nextcloud "Maintenance Mode", you can push the hardware button **shortly, once**. The
  NextBox will then switch-off the maintenance mode. Please avoid this, if possible.

**Q:** Why am I getting a permission warning for ``/var/www/html/custom_apps/nextbox`` inside the Nextcloud settings overview?
  This is a "feature". The NextBox Nextcloud App is installed on the system
  with the Debian nextbox package. To avoid an accidental deletion of the NextBox 
  Nextcloud App from within the Nextcloud app management, the stated directory 
  can not be written by Nextcloud, this is what Nextcloud is complaining about here.

**Q:** How can I run Nextcloud's `occ`?
  As Nextcloud is running inside a Docker container, you need to be root and execute the following:
  ``docker exec -it -u www-data nextbox-compose_app_1 /var/www/html/occ``


.. _USB Documentation: https://www.raspberrypi.org/documentation/hardware/raspberrypi/usb/README.md
.. _NextBox' GitHub: https://github.com/Nitrokey/nextbox-board
.. _nextbox.local: http://nextbox.local
.. _External storage support: https://docs.nextcloud.com/server/20/admin_manual/configuration_files/external_storage_configuration_gui.html
.. _RPi Power Supply: https://www.raspberrypi.org/documentation/hardware/raspberrypi/power/README.md
.. _typical bare-board power consumption: https://www.raspberrypi.org/documentation/hardware/raspberrypi/power/README.md
.. _Putty Documentation: https://www.ssh.com/academy/ssh/putty/public-key-authentication
.. _Nextcloud WebDAV documentation: https://docs.nextcloud.com/server/20/user_manual/en/files/access_webdav.html


