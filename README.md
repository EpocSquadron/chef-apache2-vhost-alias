Description
===========

This cookbook is designed to set up a wildcard virtual host definition for a directory. For instance, if one were to store all of their sites in `/var/www/sites/`, each directory can be accessed at `subdirectory-name.local` where the document root for the site is `/var/www/sites/subdirectory-name/public_html`.  All of the details are configurable of course.

Requirements
============

Currently only tested on Ubuntu Server 12.04LTS. Needs to be loaded after apache2.

Attributes
==========

Usage
=====

