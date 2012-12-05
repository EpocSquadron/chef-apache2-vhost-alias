#
# Cookbook Name:: dynamic-vhosts
# Recipe:: default
#
# Copyright 2012, Digital Surgeons
#

# cookbook-syslog-ng/recipes/default.rb

include_recipe "apache2"
include_recipe "mysql::server"
include_recipe "database"
include_recipe "dynamic-vhosts::mod_vhost_alias"

# Allow host system to connect to mysql
# From: https://github.com/afhole/vagrant-lamp/blob/master/cookbooks/vagrant_main/recipes/default.rb
mysql_connection_info = {
	:host => "localhost",
	:username => 'root',
	:password => node['mysql']['server_root_password']
}

mysql_database_user 'root' do
  connection mysql_connection_info
  password node['mysql']['server_root_password']
  host "192.168.33.1"
  action :grant
end

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

	# Pull in the php recipe.
	include_recipe "php"

	# Make a directory for includes.
	directory "#{node['apache']['dir']}/includes" do
		mode 00755
		owner "root"
		group node['apache']['root_group']
	end

	# Insert the auto_prepend_file
	template "setDocRoot.php" do
		path "#{node['apache']['dir']}/includes/setDocRoot.php"
		source "setDocRoot.php"
		owner "root"
		group node['apache']['root_group']
		mode 00644
		backup false
		notifies :restart, "service[apache2]"
	end
end
