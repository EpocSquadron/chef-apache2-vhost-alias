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
