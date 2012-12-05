#
# Cookbook Name:: dynamic-vhosts
# Recipe:: default
#
# Copyright 2012, Digital Surgeons
#
# All rights reserved - Do Not Redistribute
#

# cookbook-syslog-ng/recipes/default.rb

include_recipe "apache2"
include_recipe "apache2::mod_vhost_alias"
include_recipe "php"

# Install the generic vhosts file.
template "httpd-vhosts.conf" do
	path "#{node['apache']['dir']}/conf.d/httpd-vhosts.conf"
	source "httpd-vhosts.conf.erb"
	owner "root"
	group node['apache']['root_group']
	mode 00644
	backup false
	notifies :restart, "service[apache2]"
end

if node['dynamic-vhosts']['using_php']

	# Make a directory for includes.
	directory "#{node['apache']['dir']}/includes" do
	  mode 00755
	  owner "root"
	  group node['apache']['root_group']
	end

	# Insert the auto_prepend_file
	template "setDocRoot.php" do
		path "#{node['apache']['dir']}/includes/setDocRoot.php"
		source "setDocRoot.php.erb"
		owner "root"
		group node['apache']['root_group']
		mode 00644
		backup false
		notifies :restart, "service[apache2]"
	end
end
