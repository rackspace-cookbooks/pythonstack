#
# Cookbook Name:: wrapper
# Recipe:: default
#
# Copyright 2014, Rackspace
#
#
%w(
  stack_commons::mysql_base
  stack_commons::postgresql_base
  stack_commons::mongodb_standalone
  stack_commons::memcached
  stack_commons::varnish
  stack_commons::rabbitmq
  stack_commons::redis_single
  pythonstack::application_python
  wrapper::demo
).each do |recipe|
  include_recipe recipe
end
