
include_recipe "mysql::server"

mysql_connection_info = {
	:host => "localhost",
	:username => 'root',
	:password => node['mysql']['server_root_password']
}

# For each directory in /var/www/
directories = Dir.glob("/var/www/[^.]*").select {|f| File.directory? f}

directories.each do |dir_name|
	adjusted_name = dir_name.sub(/\/var\/www\//, '')[0,10]

	# Make a database named after the directory
	mysql_database adjusted_name do
		connection mysql_connection_info
		action :create
	end

	# Make a dedicated localhost only user for it
	mysql_database_user adjusted_name do
		connection mysql_connection_info
		password 'root'
		database_name dir_name
		host '%'
		action [:create, :grant]
	end
end
