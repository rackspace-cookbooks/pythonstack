# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: nginx
#
# Copyright 2014, Rackspace UK, Ltd.
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
elsif debian?
  include_recipe 'apt'
end

# Include the necessary recipes.
%w(platformstack::monitors platformstack::iptables ).each do |recipe|
  include_recipe recipe
end

# Install Uwsgi
include_recipe 'uwsgi'

# Pid is different on Ubuntu 14, causing nginx service to fail https://github.com/miketheman/nginx/issues/248
if ubuntu_trusty?
  node.default['nginx']['pid'] = '/run/nginx.pid'
end

# Install Nginx
include_recipe 'nginx'

# Create the sites.
unless node['nginx']['sites'].nil?
  node['nginx']['sites'].each do | site_name |
    site_name = site_name[0]
    site = node['nginx']['sites'][site_name]

    add_iptables_rule('INPUT', "-m tcp -p tcp --dport #{site['port']} -j ACCEPT", 100, 'Allow access to nginx')


    # Uwsgi set up
    uwsgi_service site_name do
      home_path "#{site['docroot']}/current"
      pid_path "/var/run/uwsgi-#{site_name}.pid"
      host "127.0.0.1"
      port site['uswgi_port']
      worker_processes 2
      master true
      die_on_term true
      app site['app']
    end

    # Nginx set up
    template site_name do
      cookbook 'pythonstack'
      source "nginx/sites/#{site_name}.erb"
      path "#{node['nginx']['dir']}/sites-available/#{site_name}"
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        name: site_name,
        port: site['port'],
        uswgi_port: site['uswgi_port'],
        server_name: site['server_name'],
        server_aliases: site['server_alias'],
        allow_override: site['allow_override'],
        errorlog: site['errorlog'],
        customlog: site['customlog'],
        loglevel: site['loglevel']
      )
      notifies :reload, 'service[nginx]'
    end
    nginx_site site_name do
          enable true
    end
    template "http-monitor-#{site['server_name']}" do
      cookbook 'pythonstack'
      source 'monitoring-remote-http.yaml.erb'
      path "/etc/rackspace-monitoring-agent.conf.d/#{site['server_name']}-http-monitor.yaml"
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        http_port: site['port'],
        server_name: site['server_name']
      )
      notifies 'restart', 'service[rackspace-monitoring-agent]', 'delayed'
      action 'create'
      only_if { node.deep_fetch('platformstack', 'cloud_monitoring', 'enabled') }
    end
  end
end
