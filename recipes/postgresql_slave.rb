#
# Cookbook Name:: pythonstack
# Recipe:: postgresql_slave
#
# Copyright 2014, Rackspace
#

include_recipe 'pythonstack::postgresql_base'

include_recipe 'pg-multi::pg_slave'
