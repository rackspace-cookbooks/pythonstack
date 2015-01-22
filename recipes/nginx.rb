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

stackname = 'pythonstack'
return 0 unless node[stackname]['webserver_deployment']['enabled']

include_recipe 'chef-sugar'
include_recipe "#{stackname}::default_unless"

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
  apt
  platformstack::monitors
  platformstack::iptables
).each do |recipe|
  include_recipe recipe
end

# Install Uwsgi
include_recipe 'build-essential'
include_recipe 'uwsgi'

# Pid is different on Ubuntu 14, causing nginx service to fail https://github.com/miketheman/nginx/issues/248
node.default['nginx']['pid'] = '/run/nginx.pid' if ubuntu_trusty?
# Uwsgi path is different on Centos
if rhel?
  node.default['nginx']['uwsgi']['bin'] = '/usr/bin/uwsgi'
else
  node.default['nginx']['uwsgi']['bin'] = '/usr/local/bin/uwsgi'
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

listen_ports = []
# Create the sites.
node[stackname]['nginx']['sites'].each do |port, sites|
  listen_ports |= [port]
  add_iptables_rule('INPUT', "-m tcp -p tcp --dport #{port} -j ACCEPT", 100, 'Allow access to nginx')
  sites.each do |site_name, site_opts|
    # set up uwsgi per site/port combo
    template "#{site_name}-#{site_opts['uwsgi_port']}-uwsgi.ini" do
      cookbook site_opts['uwsgi_cookbook']
      source site_opts['uwsgi_template']
      path "#{node['nginx']['dir']}/#{site_name}-#{site_opts['uwsgi_port']}-uwsgi.ini"
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        name: "#{site_name}-#{port}",
        home_path: "#{site_opts['docroot']}/current",
        pid_path: "/var/run/uwsgi-#{site_name}-#{port}.pid",
        uwsgi_port: site_opts['uwsgi_port'],
        stats_port: site_opts['uwsgi_stats_port'],
        app: site_opts['app'],
        uid: node['nginx']['user'],
        gid: node['nginx']['group'],
        options: site_opts['uwsgi_options']
      )
    end
    uwsgi_service "#{site_name}-#{site_opts['uwsgi_port']}" do
      pid_path "/var/run/uwsgi-#{site_name}-#{site_opts['uwsgi_port']}.pid"
      home_path "#{site_opts['docroot']}/current"
      uwsgi_bin node['nginx']['uwsgi']['bin']
      config_file "#{node['nginx']['dir']}/#{site_name}-#{site_opts['uwsgi_port']}-uwsgi.ini"
    end
    # Reload service if pythonstack.ini has been modified
    service "uwsgi-#{site_name}-#{site_opts['uwsgi_port']}" do
      supports restart: true, reload: true
      subscribes :restart, 'template[pythonstack.ini]', :delayed
    end

    # Nginx set up
    template "#{site_name}-#{port}" do
      cookbook site_opts['cookbook']
      source site_opts['template']
      path "#{node['nginx']['dir']}/sites-available/#{site_name}-#{port}.conf"
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        name: "#{site_name}-#{port}",
        port: port,
        uwsgi_port: site_opts['uwsgi_port'],
        server_aliases: site_opts['server_alias'].empty? ? [site_name] : site_opts['server_alias'],
        docroot: site_opts['docroot'],
        errorlog: site_opts['errorlog'],
        customlog: site_opts['customlog']
      )
      notifies :reload, 'service[nginx]'
    end
    nginx_site "#{site_name}-#{port}.conf" do
      enable true
      notifies :reload, 'service[nginx]'
    end
    template "http-monitor-#{site_name}-#{port}" do
      cookbook stackname
      source 'monitoring-remote-http.yaml.erb'
      path "/etc/rackspace-monitoring-agent.conf.d/#{site_name}-#{port}-http-monitor.yaml"
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        http_port: port,
        server_name: site_opts['monitoring_hostname']
      )
      notifies 'restart', 'service[rackspace-monitoring-agent]', 'delayed'
      action 'create'
      only_if { node.deep_fetch('platformstack', 'cloud_monitoring', 'enabled') }
    end
  end
end

node.default['nginx']['listen_ports'] = listen_ports
