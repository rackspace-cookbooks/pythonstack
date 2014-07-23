#
# Cookbook Name:: pythonstack
# Recipe:: mysql_slave
#
# Copyright 2014, Rackspace
#

include_recipe 'pythonstack::mysql_base'

include_recipe 'mysql-multi::mysql_slave'
