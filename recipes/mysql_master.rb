#
# Cookbook Name:: pythonstack
# Recipe:: mysql_master
#
# Copyright 2014, Rackspace
#

include_recipe 'chef-sugar'
include_recipe 'pythonstack::mysql_base'
include_recipe 'mysql-multi::mysql_master'
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

node['apache']['sites'].each do |site_name|
  site_name = site_name[0]

  mysql_database site_name do
    connection connection_info
    action 'create'
  end

  node.set_unless['apache']['sites'][site_name]['mysql_password'] = secure_password
  if Chef::Config[:solo]
    Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
    app_nodes = []
  else
    app_nodes = search(:node, 'recipes:pythonstack\:\:application_python' << " AND chef_environment:#{node.chef_environment}")
  end

  if Chef::Config[:solo]
    Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
    app_nodes = []
  else
    app_nodes = search(:node, 'recipes:pythonstack\:\:application_python' << " AND chef_environment:#{node.chef_environment}")
  end

  app_nodes.each do |app_node|
    mysql_database_user site_name do
      connection connection_info
      password node['apache']['sites'][site_name]['mysql_password']
      host best_ip_for(app_node)
      database_name site_name
      privileges %w(select update insert)
      retries 2
      retry_delay 2
      action %w(create grant)
    end
  end
end
