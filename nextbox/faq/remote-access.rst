Remote Access FAQ
=================

**Q:** What is the correct WebDAV URL?
  The full URL to use for WebDAV is:
  ``https://my.domain.tld/remote.php/webdav/``, there have been reports that
  for native Windows WebDAV you might need:
  ``https://my.domain.tld/remote.php/dav/files/USERNAME`` with *USERNAME* being
  the username you would like to use.

**Q:** Can I access my Nextcloud instance using WebDAV?
  Yes, please see `Nextcloud WebDAV documentation`_ for a complete overview. A
  simple mount for unix-like systems might look like this: ``mount -t davfs
  https://my.domain.tld/remote.php/webdav/ /mnt/target/path`` while making sure
  that the ``davfs2`` package is installed. For Windows please additionally
  read these :doc:`docs <clients/windows>`.

**Q:**: Why does my Android smartphone's browser not open: ``http://nextbox.local`` 
  As of today the technology needed to use ``.local`` URLs is not supported by various (stock)
  Android browser(s). The mechanism is based on ``mDNS``. One possible workaround is to use a
  3rd party app like BonjourBrowser to discover all mDNS services in your network.

.. _USB Documentation: https://www.raspberrypi.org/documentation/hardware/raspberrypi/usb/README.md
.. _NextBox' GitHub: https://github.com/Nitrokey/nextbox-board
.. _nextbox.local: http://nextbox.local
.. _External storage support: https://docs.nextcloud.com/server/20/admin_manual/configuration_files/external_storage_configuration_gui.html
.. _RPi Power Supply: https://www.raspberrypi.org/documentation/hardware/raspberrypi/power/README.md
.. _typical bare-board power consumption: https://www.raspberrypi.org/documentation/hardware/raspberrypi/power/README.md
.. _Putty Documentation: https://www.ssh.com/academy/ssh/putty/public-key-authentication
.. _Nextcloud WebDAV documentation: https://docs.nextcloud.com/server/20/user_manual/en/files/access_webdav.html


