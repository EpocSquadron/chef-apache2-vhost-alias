Description
===========

This cookbook is designed to set up a wildcard virtual host definition for a directory. For instance, if one were to store all of their sites in `/var/www/sites/`, each directory can be accessed at `subdirectory-name.local` where the document root for the site is `/var/www/sites/subdirectory-name/public_html`.  All of the details are configurable of course.

Requirements
============

Currently only tested on Ubuntu Server 12.04LTS. Needs to be loaded after apache2.

Attributes
==========

 - 'server_extension': What extension to recognize virtualhosts under. If you want to go to project_directory.work.dev, this would be "work.dev".
 - 'docroot_directory': Where the docroot for the virtual hosts will be.
 - 'docroot_subdirectory': Which subdirectory of folders in docroot directory (typically public_html).
 - 'using_php': Whether or not you're using php, so we can include the docroot global fix.

Usage
=====

