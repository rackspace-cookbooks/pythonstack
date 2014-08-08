# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: nginx
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

case node['platform_family']
when 'debian'
  package 'automake'
when 'rhel'
end

# Include the necessary recipes.
%w(platformstack::monitors platformstack::iptables apt chef-sugar nginx::default nginx::http_geoip_module).each do |recipe|
  include_recipe recipe
end

# Create the sites.
unless node['nginx']['sites'].nil?
  node['nginx']['sites'].each do | site_name |
    site_name = site_name[0]
    site = node['nginx']['sites'][site_name]

    add_iptables_rule('INPUT', "-m tcp -p tcp --dport #{site['port']} -j ACCEPT", 100, 'Allow access to nginx')

    template "#{site['server_name']}_nginx.conf" do
      cookbook 'pythonstack'
      source 'nginx/sites/default_nginx.conf.erb'
      path "/etc/nginx/sites-available/#{site['server_name']}"
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        nginx_port: site['port'],
        server_name: site['server_name'],
        upstream_port: site['upstream']['port'],
        upstream_name: site['upstream']['name'],
        wsgi_script: site['script_name'],
        static_location: site['static_location'],
        media_location: site['media_location']
      )
    end

    nginx_site site_name do
      enable true if File.exist?("#{site['docroot']}/wsgi.py")
    end

    template "http-monitor-#{site['server_name']}" do
      cookbook 'pythonstack'
      source 'monitoring-remote-http.yaml.erb'
      path "/etc/rackspace-monitoring-agent.conf.d/#{site['server_name']}-http-monitor.yaml"
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        apache_port: site['port'],
        server_name: site['server_name']
      )
      notifies 'restart', 'service[rackspace-monitoring-agent]', 'delayed'
      action 'create'
      only_if { node.deep_fetch('platformstack', 'cloud_monitoring', 'enabled') }
    end
  end
end
