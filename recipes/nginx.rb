# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: nginx
#
# Copyright 2014, Rackspace US, Inc.
#
# Licensed under the apache License, Version 2.0 (the "License");
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

include_recipe 'chef-sugar'

if rhel?
  include_recipe 'yum-epel'
  include_recipe 'yum-ius'
  # dependencies for uwsgi recipe (otherwise we have an error on virtualenv install)
  include_recipe 'python::package'
  include_recipe 'python::pip'
  python_pip 'setuptools' do
    action :upgrade
  end
end

# Include the necessary recipes.
%w(
  platformstack::monitors
  platformstack::iptables
  apt
).each do |recipe|
  include_recipe recipe
end

# Install Uwsgi
include_recipe 'build-essential'
include_recipe 'uwsgi'

# Pid is different on Ubuntu 14, causing nginx service to fail https://github.com/miketheman/nginx/issues/248
if ubuntu_trusty?
  node.default['nginx']['pid'] = '/run/nginx.pid'
end

# Install Nginx
include_recipe 'nginx'

# Properly disable default vhost on Rhel (https://github.com/miketheman/nginx/pull/230/files)
# FIXME: should be removed once the PR has been merged
if !node['nginx']['default_site_enabled'] && (node['platform_family'] == 'rhel' || node['platform_family'] == 'fedora')
  %w(default.conf example_ssl.conf).each do |config|
    file "/etc/nginx/conf.d/#{config}" do
      action :delete
    end
  end
end

# If not defined drop out
if node.deep_fetch('nginx', 'sites').nil?
  return 0
elsif node.deep_fetch('nginx', 'sites').values[0].nil?
  return 0
end

# Create the sites.
node['nginx']['sites'].each do |site_name, site_opts|
  add_iptables_rule('INPUT', "-m tcp -p tcp --dport #{site_opts['port']} -j ACCEPT", 100, 'Allow access to nginx')

  # Uwsgi path is different on Centos
  if rhel?
    node.default['nginx']['uwsgi']['bin'] = '/usr/bin/uwsgi'
  else
    node.default['nginx']['uwsgi']['bin'] = '/usr/local/bin/uwsgi'
  end

  template "#{site_name}-uwsgi-ini" do
    cookbook 'pythonstack'
    source 'nginx/uwsgi.ini.erb'
    path "#{node['nginx']['dir']}/#{site_name}.ini"
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      name: site_name,
      home_path: "#{site_opts['docroot']}/current",
      pid_path: "/var/run/uwsgi-#{site_name}.pid",
      uwsgi_port: site_opts['uwsgi_port'],
      stats_port: site_opts['uwsgi_stats_port'],
      app: site_opts['app'],
      uid: node['nginx']['user'],
      gid: node['nginx']['group'],
      options: site_opts['uwsgi_options']
    )
  end

  uwsgi_service site_name do
    pid_path "/var/run/uwsgi-#{site_name}.pid"
    home_path "#{site_opts['docroot']}/current"
    uwsgi_bin node['nginx']['uwsgi']['bin'] if node['nginx']['uwsgi']['bin']
    config_file "#{node['nginx']['dir']}/#{site_name}.ini"
  end

  # Reload service if pythonstack.ini has been modified
  service "uwsgi-#{site_name}" do
    supports restart: true, reload: true
    subscribes :restart, 'template[pythonstack.ini]', :delayed
  end

  # Nginx set up
  template site_name do
    cookbook site_opts['cookbook']
    source "nginx/sites/#{site_name}.erb"
    path "#{node['nginx']['dir']}/sites-available/#{site_name}"
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      name: site_name,
      port: site_opts['port'],
      uwsgi_port: site_opts['uwsgi_port'],
      server_name: site_opts['server_name'],
      server_aliases: site_opts['server_alias'],
      docroot: site_opts['docroot'],
      errorlog: site_opts['errorlog'],
      customlog: site_opts['customlog']
    )
    notifies :reload, 'service[nginx]'
  end
  nginx_site site_name do
    enable true
    notifies :reload, 'service[nginx]'
  end
  template "http-monitor-#{site_opts['server_name']}" do
    cookbook 'pythonstack'
    source 'monitoring-remote-http.yaml.erb'
    path "/etc/rackspace-monitoring-agent.conf.d/#{site_opts['server_name']}-http-monitor.yaml"
    owner 'root'
    group 'root'
    mode '0644'
    variables(
      http_port: site_opts['port'],
      server_name: site_opts['server_name']
    )
    notifies 'restart', 'service[rackspace-monitoring-agent]', 'delayed'
    action 'create'
    only_if { node.deep_fetch('platformstack', 'cloud_monitoring', 'enabled') }
  end
end
