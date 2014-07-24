# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: logserver
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

# Include the necessary recipes.
%w(pythonstack::default apache2::default apache2::mod_proxy apache2::mod_proxy_ajp apache2::mod_proxy_balancer apache2::mod_proxy_connect apache2::mod_headers apache2::deflate apache2::mod_proxy_http chef-sugar graylog).each do |recipe|
  include_recipe recipe
end

add_iptables_rule('INPUT', "-p tcp --dport #{node['graylog']['tcp_inputport']} -j ACCEPT", 9997, 'allow all nodes to connect')

template 'tcp_input' do
  cookbook 'pythonstack'
  source 'input.sh.erb'
  path '/root/input.sh'
  owner 'root'
  group 'root'
  mode '00750'
  action 'create'
end

web_app 'lognode.example.com' do
  port '80'
  cookbook 'pythonstack'
  template 'lognode.example.com.erb'
end

execute 'setup tcp input' do
  command "/root/input.sh #{node['graylog']['server']['graylog2.conf']['password_secret']} #{node['graylog']['tcp_inputport']}"
end
