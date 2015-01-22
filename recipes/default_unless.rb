# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: default_unless
#
# Copyright 2014, Rackspace US, Inc.
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

stackname = 'pythonstack'

# set demo if needed
node.default[stackname][node[stackname]['webserver']]['sites'] = node[stackname]['demo'][node[stackname]['webserver']]['sites'] if node[stackname]['demo']['enabled']

# general stuff
node.default_unless[node[stackname]['webserver']]['user'] = 'nobody'
node.default_unless[node[stackname]['webserver']]['group'] = 'nobody'
node.default_unless[stackname][node[stackname]['webserver']]['sites'] = {}

# server specific stuff
port_counter = 1 # needed for uwsgi auto port assignment
node[stackname][node[stackname]['webserver']]['sites'].each do |port, sites|
  sites.each do |site_name, site_opts|
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['revision'] = 'master'
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['repository'] = ''
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['deploy_key'] = '/root/.ssh/id_rsa'
    # now for some apache/nginx specific stuff
    next unless %w(apache nginx).include?(node[stackname]['webserver'])
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['cookbook'] = stackname
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['server_alias'] = []
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['docroot'] = "/var/www/#{site_name}/#{port}"
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['monitoring_hostname'] = site_name
    node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['customlog'] =
      "#{node[node[stackname]['webserver']]['log_dir']}/#{site_name}-#{port}-access.log combined"
    if node[stackname]['webserver'] == 'apache'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['server_admin'] = 'demo@demo.com'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['template'] = 'apache2/sites/example.com.erb'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['server_name'] = site_name
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['allow_override'] = ['All']
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['loglevel'] = 'warn'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['script_name'] = 'wsgi.py'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['errorlog'] = # ~FC047
        "#{node['apache']['log_dir']}/#{site_name}-#{port}-error.log"
    elsif node[stackname]['webserver'] == 'nginx'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['template'] = 'nginx/sites/example.com.erb'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['errorlog'] = # ~FC047
        "#{node['nginx']['log_dir']}/#{site_name}-#{port}-error.log info"
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['app'] = 'demo:app'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['uwsgi_options'] = {}
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['uwsgi_cookbook'] = 'pythonstack'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['uwsgi_template'] = 'nginx/uwsgi.ini.erb'
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['uwsgi_port'] = 20_000 + port_counter
      node.default_unless[stackname][node[stackname]['webserver']]['sites'][port][site_name]['uwsgi_stats_port'] = 1716 + port_counter
    end
    port_counter += 1
  end
end
