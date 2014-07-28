# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: application_python
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

include_recipe 'pythonstack::apache'
include_recipe 'git'
include_recipe 'python::package'
include_recipe 'python'

python_pip 'distribute'
python_pip 'flask'
python_pip 'mysql-connector-python' do
  options '--allow-external'
end
python_pip 'gunicorn'
python_pip 'MySQL-python' do
  options '--allow-external'
end

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
  memcached_node = nil
  db_node = nil
else
  memcached_node = search('node', 'role:memcached' << " AND chef_environment:#{node.chef_environment}").first
  db_node = search('node', 'role:db' << " AND chef_environment:#{node.chef_environment}").first
end

node.set['pythonstack']['memcached']['host'] = memcached_node.nil? ? nil : best_ip_for(memcached_node)
node.set['pythonstack']['database']['host'] = db_node.nil? ? 'localhost' : best_ip_for(db_node)
