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
if platform_family?('debian')
  package 'python-mysqldb'
end
if platform_family?('rhel')
  # needed because Mysql-python depends on it
  package 'mysql'
  package 'mysql-devel'
  include_recipe 'build-essential'
end
python_pip 'configparser'
python_pip 'sqlalchemy'
python_pip 'flask'
python_pip 'python-memcached'
python_pip 'gunicorn'
python_pip 'MySQL-python' do
  options '--allow-external' unless platform_family?('rhel')
end

node['apache']['sites'].each do | site_name |
  site_name = site_name[0]

  application site_name do
    path node['apache']['sites'][site_name]['docroot']
    owner node['apache']['user']
    group node['apache']['group']
    deploy_key node['apache']['sites'][site_name]['deploy_key']
    repository node['apache']['sites'][site_name]['repository']
    revision node['apache']['sites'][site_name]['revision']
  end
end

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
  mysql_node = nil
else
  mysql_node = search('node', "recipes:pythonstack\\:\\:mysql_base AND chef_environment:#{node.chef_environment}").first
end
template 'pythonstack.ini' do
  path '/etc/pythonstack.ini'
  cookbook node['pythonstack']['ini']['cookbook']
  source 'pythonstack.ini.erb'
  owner 'root'
  group node['apache']['group']
  mode '00640'
  variables(
    cookbook_name: cookbook_name,
    # if it responds then we will create the config section in the ini file
    mysql: if mysql_node.respond_to?('deep_fetch')
             if mysql_node.deep_fetch('apache', 'sites').nil?
               nil
             else
               mysql_node.deep_fetch('apache', 'sites').values[0]['mysql_password'].nil? ? nil : mysql_node
             end
           end,
    mysql_master_host: if mysql_node.respond_to?('deep_fetch')
                         best_ip_for(mysql_node)
                       else
                         nil
                       end
  )
  action 'create'
end

# backups
node.default['rackspace']['datacenter'] = node['rackspace']['region']
node.set_unless['rackspace_cloudbackup']['backups_defaults']['cloud_notify_email'] = 'example@example.com'
# we will want to change this when https://github.com/rackspace-cookbooks/rackspace_cloudbackup/issues/17 is fixed
node.default['rackspace_cloudbackup']['backups'] =
  [
    {
      location: node['apache']['docroot_dir'],
      enable: node['pythonstack']['rackspace_cloudbackup']['apache_docroot']['enable'],
      comment: 'Web Content Backup',
      cloud: { notify_email: node['rackspace_cloudbackup']['backups_defaults']['cloud_notify_email'] }
    }
  ]

tag('python_app_node')
