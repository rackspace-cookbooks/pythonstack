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

include_recipe 'pythonstack::default'
include_recipe 'pythonstack::apache'
include_recipe 'git'

case node['platform_family']
when 'debian'
  option = '--allow-external'
when 'rhel'
  option = ''
end

python_pip 'flask'
python_pip 'mysql-connector-python' do
  options option
end
python_pip 'gunicorn'

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  memcached_node = search('node', 'role:memcached'\
                  " AND chef_environment:#{node.chef_environment}").first
  if !memcached_node.nil?
    node.set['pythonstack']['memcached']['host'] = best_ip_for(memcached_node)
  else
    node.set['pythonstack']['memcached']['host'] = nil
  end
  db_node = search('node', 'role:db'\
                  " AND chef_environment:#{node.chef_environment}").first
  if db_node.nil?
    node.set['pythonstack']['database']['host'] = 'localhost'
  else
    node.set['pythonstack']['database']['host'] = best_ip_for(db_node)
  end
end
