
include_recipe "mysql::server"

mysql_connection_info = {
	:host => "localhost",
	:username => 'root',
	:password => node['mysql']['server_root_password']
}

# For each directory in /var/www/
directories = Dir.glob('[^.]*').select {|f| File.directory? f}

directories.each do |dir_name|
	# Make a database named after the directory
	mysql_database dir_name do
		connection mysql_connection_info
		action :create
	end

	# Make a dedicated localhost only user for it
	mysql_database_user 'foo_user' do
		connection mysql_connection_info
		password 'root'
		database_name dir_name
		host 'localhost'
		action [:create, :grant]
	end
end
