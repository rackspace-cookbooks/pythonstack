# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: newrelic
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
# The node['newrelic']['license'] attribute needs to be set for NewRelic to work
if node['newrelic']['license']
  node.set['pythonstack']['newrelic']['application_monitoring'] = 'true'
  node.override['newrelic']['application_monitoring']['daemon']['ssl'] = true
  node.override['newrelic']['server_monitoring']['ssl'] = true
  include_recipe 'platformstack::default'
  include_recipe 'newrelic::python_agent'
  node.default['newrelic_meetme_plugin']['license'] = node['newrelic']['license']

  meetme_config = {}
  if node['recipes'].include?('memcached')
    meetme_config['memcached'] = {
      'name' => node['hostname'],
      'host' => 'localhost',
      'port' => 11_211
    }
  end

  if node['recipes'].include?('rabbitmq')
    meetme_config['rabbitmq'] = {
      'name' => node['hostname'],
      'host' => 'localhost',
      'port' => 15_672,
      'username' => 'guest',
      'password' => 'guest',
      'api_path' => '/api'
    }
  end

  if node['recipes'].include?('nginx')
    meetme_config['nginx'] = {
      'name' => node['hostname'],
      'host' => 'localhost',
      'port' => 80,
      'path' => '/server-status'
    }
    meetme_config['uwsgi'] = {
      'name' => node['hostname'],
      'host' => 'localhost',
      'port' => 1717
    }
  end
  node.override['newrelic_meetme_plugin']['services'] = meetme_config

  node.default['newrelic_meetme_plugin']['package_name'] = 'newrelic-plugin-agent'

  include_recipe 'python::package'
  include_recipe 'python::pip'
  python_pip 'setuptools' do
    action :upgrade
    version node['python']['setuptools_version']
  end

  include_recipe 'python'
  include_recipe 'newrelic_meetme_plugin'
else
  Chef::Log.warn('The New Relic license attribute is not set!')
end
