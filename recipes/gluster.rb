# Encoding: utf-8
#
# Cookbook Name:: pythonstack
# Recipe:: gluster
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

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
else
  # get the list of gluster servers and pick one randomly to use as the one we connect to
  gluster_ips = []
  servers = node.deep_fetch['rackspace_gluster']['config']['server']['glusters'].values[0]['nodes']
  if servers.respond_to?('each')
    servers.each do |server|
      gluster_ips.push(server[1]['ip'])
    end
  end
  node.set_unless['pythonstack']['gluster_connect_ip'] = gluster_ips.sample

  # install gluster mount
  package 'glusterfs-client' do
    action :install
  end

  # set up the mountpoint
  mount 'webapp-mountpoint' do
    fstype 'glusterfs'
    device "#{node['pythonstack']['gluster_connect_ip']}:/#{node['rackspace_gluster']['config']['server']['glusters'].values[0]['volume']}"
    mount_point '/var/www/'
    action %w(mount enable)
  end
end
