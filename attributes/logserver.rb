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

default['graylog']['server']['graylog2.conf']['password_secret'] = 'CHANGEME!'
default['graylog']['server']['graylog2.conf']['root_password_sha2'] = '90aba6bd1562f5af8f912ac3fe00d9ed7387bd84ec32f3da7415f4078da5efb8'
default['graylog']['web_interface']['graylog2-web-interface.conf']['application.secret'] = '90aba6bd1562f5af8f912ac3fe00d9ed7387bd84ec32f3da7415f4078da5efb8'
