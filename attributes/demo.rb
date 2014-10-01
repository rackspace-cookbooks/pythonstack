# Encoding: utf-8
#
# Cookbook Name:: pythonstack
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

default['pythonstack']['demo']['enabled'] = false

site1 = 'example.com'
site2 = 'test.com'
version1 = '0.0.6'
port1 = '80'
port2 = '8080'

# apache site1
default['pythonstack']['demo']['apache']['sites'][port1][site1]['template']       = "apache2/sites/#{site1}-#{port1}.erb"
default['pythonstack']['demo']['apache']['sites'][port1][site1]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['apache']['sites'][port1][site1]['server_name']    = site1
default['pythonstack']['demo']['apache']['sites'][port1][site1]['server_alias']   = ["test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['apache']['sites'][port1][site1]['docroot']        = "/var/www/#{site1}/#{port1}"
default['pythonstack']['demo']['apache']['sites'][port1][site1]['errorlog']       = "#{node['apache']['log_dir']}/#{site1}-#{port1}-error.log"
default['pythonstack']['demo']['apache']['sites'][port1][site1]['customlog']      = "#{node['apache']['log_dir']}/#{site1}-#{port1}-access.log combined"
default['pythonstack']['demo']['apache']['sites'][port1][site1]['allow_override'] = ['All']
default['pythonstack']['demo']['apache']['sites'][port1][site1]['loglevel']       = 'warn'
default['pythonstack']['demo']['apache']['sites'][port1][site1]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port1][site1]['server_admin']   = 'demo@demo.com'
default['pythonstack']['demo']['apache']['sites'][port1][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port1][site1]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['apache']['sites'][port1][site1]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['apache']['sites'][port2][site1]['template']       = "apache2/sites/#{site1}-#{port2}.erb"
default['pythonstack']['demo']['apache']['sites'][port2][site1]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['apache']['sites'][port2][site1]['server_name']    = site1
default['pythonstack']['demo']['apache']['sites'][port2][site1]['server_alias']   = ["test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['apache']['sites'][port2][site1]['docroot']        = "/var/www/#{site1}/#{port2}"
default['pythonstack']['demo']['apache']['sites'][port2][site1]['errorlog']       = "#{node['apache']['log_dir']}/#{site1}-#{port2}-error.log"
default['pythonstack']['demo']['apache']['sites'][port2][site1]['customlog']      = "#{node['apache']['log_dir']}/#{site1}-#{port2}-access.log combined"
default['pythonstack']['demo']['apache']['sites'][port2][site1]['allow_override'] = ['All']
default['pythonstack']['demo']['apache']['sites'][port2][site1]['loglevel']       = 'warn'
default['pythonstack']['demo']['apache']['sites'][port2][site1]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port2][site1]['server_admin']   = 'demo@demo.com'
default['pythonstack']['demo']['apache']['sites'][port2][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port2][site1]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['apache']['sites'][port2][site1]['deploy_key']     = '/root/.ssh/id_rsa'

# apache site2
default['pythonstack']['demo']['apache']['sites'][port1][site2]['template']       = "apache2/sites/#{site2}-#{port1}.erb"
default['pythonstack']['demo']['apache']['sites'][port1][site2]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['apache']['sites'][port1][site2]['server_name']    = site2
default['pythonstack']['demo']['apache']['sites'][port1][site2]['server_alias']   = ["test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['apache']['sites'][port1][site2]['docroot']        = "/var/www/#{site2}/#{port1}"
default['pythonstack']['demo']['apache']['sites'][port1][site2]['errorlog']       = "#{node['apache']['log_dir']}/#{site2}-#{port1}-error.log"
default['pythonstack']['demo']['apache']['sites'][port1][site2]['customlog']      = "#{node['apache']['log_dir']}/#{site2}-#{port1}-access.log combined"
default['pythonstack']['demo']['apache']['sites'][port1][site2]['allow_override'] = ['All']
default['pythonstack']['demo']['apache']['sites'][port1][site2]['loglevel']       = 'warn'
default['pythonstack']['demo']['apache']['sites'][port1][site2]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port1][site2]['server_admin']   = 'demo@demo.com'
default['pythonstack']['demo']['apache']['sites'][port1][site2]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port1][site2]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['apache']['sites'][port1][site2]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['apache']['sites'][port2][site2]['template']       = "apache2/sites/#{site2}-#{port2}.erb"
default['pythonstack']['demo']['apache']['sites'][port2][site2]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['apache']['sites'][port2][site2]['server_name']    = site2
default['pythonstack']['demo']['apache']['sites'][port2][site2]['server_alias']   = ["test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['apache']['sites'][port2][site2]['docroot']        = "/var/www/#{site2}/#{port2}"
default['pythonstack']['demo']['apache']['sites'][port2][site2]['errorlog']       = "#{node['apache']['log_dir']}/#{site2}-#{port2}-error.log"
default['pythonstack']['demo']['apache']['sites'][port2][site2]['customlog']      = "#{node['apache']['log_dir']}/#{site2}-#{port2}-access.log combined"
default['pythonstack']['demo']['apache']['sites'][port2][site2]['allow_override'] = ['All']
default['pythonstack']['demo']['apache']['sites'][port2][site2]['loglevel']       = 'warn'
default['pythonstack']['demo']['apache']['sites'][port2][site2]['script_name']    = 'wsgi.py'
default['pythonstack']['demo']['apache']['sites'][port2][site2]['server_admin']   = 'demo@demo.com'
default['pythonstack']['demo']['apache']['sites'][port2][site2]['revision']       = "v#{version1}"
default['pythonstack']['demo']['apache']['sites'][port2][site2]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['apache']['sites'][port2][site2]['deploy_key']     = '/root/.ssh/id_rsa'

# nginx site1
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['uwsgi_port']     = 20_001
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['uwsgi_stats_port'] = '1717'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['uwsgi_options']  = {}
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['uwsgi_template'] = 'nginx/uwsgi.ini.erb'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['uwsgi_cookbook'] = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['template']       = "nginx/sites/#{site1}-#{port1}.erb"
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['server_name']    = site1
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['server_alias']   = ["test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['docroot']        = "/var/www/#{site1}/#{port1}"
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['errorlog']       = "#{node['nginx']['log_dir']}/#{site1}-#{port1}-error.log info"
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['customlog']      = "#{node['nginx']['log_dir']}/#{site1}-#{port1}-access.log combined"
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['loglevel']       = 'warn'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['app']            = 'demo:app'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['nginx']['sites'][port1][site1]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['nginx']['sites'][port2][site1]['uwsgi_port']     = 20_002
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['uwsgi_stats_port'] = '1718'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['uwsgi_options']  = {}
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['uwsgi_template'] = 'nginx/uwsgi.ini.erb'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['uwsgi_cookbook'] = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['template']       = "nginx/sites/#{site1}-#{port2}.erb"
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['server_name']    = site1
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['server_alias']   = ["test.#{site1}", "www.#{site1}"]
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['docroot']        = "/var/www/#{site1}/#{port2}"
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['errorlog']       = "#{node['nginx']['log_dir']}/#{site1}-#{port2}-error.log info"
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['customlog']      = "#{node['nginx']['log_dir']}/#{site1}-#{port2}-access.log combined"
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['loglevel']       = 'warn'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['app']            = 'demo:app'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['revision']       = "v#{version1}"
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['nginx']['sites'][port2][site1]['deploy_key']     = '/root/.ssh/id_rsa'

# nginx site2
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['uwsgi_port']     = 20_003
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['uwsgi_stats_port'] = '1719'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['uwsgi_options']  = {}
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['uwsgi_template'] = 'nginx/uwsgi.ini.erb'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['uwsgi_cookbook'] = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['template']       = "nginx/sites/#{site2}-#{port1}.erb"
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['server_name']    = site2
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['server_alias']   = ["test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['docroot']        = "/var/www/#{site2}/#{port1}"
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['errorlog']       = "#{node['nginx']['log_dir']}/#{site2}-#{port1}-error.log info"
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['customlog']      = "#{node['nginx']['log_dir']}/#{site2}-#{port1}-access.log combined"
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['loglevel']       = 'warn'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['app']            = 'demo:app'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['revision']       = "v#{version1}"
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['nginx']['sites'][port1][site2]['deploy_key']     = '/root/.ssh/id_rsa'

default['pythonstack']['demo']['nginx']['sites'][port2][site2]['uwsgi_port']     = 20_004
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['uwsgi_stats_port'] = '1720'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['uwsgi_options']  = {}
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['uwsgi_template'] = 'nginx/uwsgi.ini.erb'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['uwsgi_cookbook'] = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['template']       = "nginx/sites/#{site2}-#{port2}.erb"
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['cookbook']       = 'pythonstack'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['server_name']    = site2
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['server_alias']   = ["test.#{site2}", "www.#{site2}"]
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['docroot']        = "/var/www/#{site2}/#{port2}"
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['errorlog']       = "#{node['nginx']['log_dir']}/#{site2}-#{port2}-error.log info"
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['customlog']      = "#{node['nginx']['log_dir']}/#{site2}-#{port2}-access.log combined"
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['loglevel']       = 'warn'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['server_admin']   = 'demo@demo.com'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['repository']     = 'https://github.com/rackops/flake-test-app'
default['pythonstack']['demo']['nginx']['sites'][port2][site2]['deploy_key']     = '/root/.ssh/id_rsa'
