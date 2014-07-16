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
%w(pythonstack::default database::mysql mysql::server mysql-multi).each do |recipe|
  include_recipe recipe
end

connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mysql']['server_root_password']
}

mysql_database_user node['cloud_monitoring']['agent_mysql']['user'] do
  connection connection_info
  password node['cloud_monitoring']['agent_mysql']['password']
  action 'create'
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

# allow the app nodes to connect
search_add_iptables_rules('recipes:pythonstack\:\:application_python' << " AND chef_environment:#{node.chef_environment}",
                          'INPUT', '-p tcp --dport 3306 -j ACCEPT', 9998, 'allow app nodes to connect')

include_recipe 'pythonstack::mysql_holland' if node['mysql']['holland'] == true
