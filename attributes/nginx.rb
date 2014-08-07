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

if node['pythonstack']['demo']['enabled']
  site1 = 'example.com'

  default['nginx']['sites'][site1]['port']         = 80
  default['nginx']['sites'][site1]['cookbook']     = 'pythonstack'
  default['nginx']['sites'][site1]['template']     = "nginx/sites/#{site1}.erb"
  default['nginx']['sites'][site1]['server_name']  = site1
  default['nginx']['sites'][site1]['script_name']  = '/var/www/example.com/wsgi.py'
  default['nginx']['sites'][site1]['upstream']['port'] = 8000
  default['nginx']['sites'][site1]['upstream']['name'] = 'django'
  default['nginx']['sites'][site1]['media_location'] = '/var/www/example.com/media'
  default['nginx']['sites'][site1]['static_location'] = '/var/www/example.com/static'
  default['nginx']['sites'][site1]['docroot'] = '/var/www/example.com'
end
