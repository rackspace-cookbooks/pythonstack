#
# Cookbook Name:: wrapper
# Recipe:: default
#
# Copyright 2014, Rackspace
#
#
%w(
  pythonstack::mysql_base
  pythonstack::postgresql_base
  pythonstack::mongodb_standalone
  pythonstack::memcache
  pythonstack::varnish
  pythonstack::rabbitmq
  pythonstack::redis_single
  pythonstack::application_python
  wrapper::demo
).each do |recipe|
  include_recipe recipe
end
