# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: default
#
# Copyright 2014, Rackspace UK, Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include the necessary recipes.
include_recipe 'apt' if node.platform_family?('debian')
include_recipe 'chef-sugar'
include_recipe 'platformstack::monitors'

# set passwords dynamically...
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['pythonstack']['cloud_monitoring']['agent_mysql']['password'] = secure_password
if node['mysql']['server_root_password'] == 'ilikerandompasswords'
  node.set['mysql']['server_root_password'] = secure_password
end

include_recipe 'build-essential'
include_recipe 'mysql::server'
include_recipe 'mysql::client'
include_recipe 'mysql-multi'
include_recipe 'database::mysql'

connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

# add holland user (if holland is enabled)
mysql_database_user 'holland' do
  connection connection_info
  password node['holland']['password']
  host 'localhost'
  privileges [:usage, :select, :'lock tables', :'show view', :reload, :super, :'replication client']
  retries 2
  retry_delay 2
  action [:create, :grant]
  only_if { node.deep_fetch('holland', 'enabled') }
end

mysql_database_user node['pythonstack']['cloud_monitoring']['agent_mysql']['user'] do
  connection connection_info
  password node['pythonstack']['cloud_monitoring']['agent_mysql']['password']
  action 'create'
  only_if { node.deep_fetch('platformstack', 'cloud_monitoring', 'enabled') }
end

template 'mysql-monitor' do
  cookbook 'pythonstack'
  source 'monitoring-agent-mysql.yaml.erb'
  path '/etc/rackspace-monitoring-agent.conf.d/agent-mysql-monitor.yaml'
  owner 'root'
  group 'root'
  mode '00600'
  notifies 'restart', 'service[rackspace-monitoring-agent]', 'delayed'
  action 'create'
  only_if { node.deep_fetch('platformstack', 'cloud_monitoring', 'enabled') }
end

# allow traffic to mysql port for local addresses only
search_add_iptables_rules(
  "tags:python_app_node AND chef_environment:#{node.chef_environment}",
  'INPUT', "-p tcp --dport #{node['mysql']['port']} -j ACCEPT",
  9998,
  'allow app nodes to connect to mysql')

# we don't want to create DBs or users and the like on slaves, do we?
unless includes_recipe?('pythonstack::mysql_slave')
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
      app_nodes = search(:node, "tags:python_app_node AND chef_environment:#{node.chef_environment}")
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
end
