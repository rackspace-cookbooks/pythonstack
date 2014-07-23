#
# Cookbook Name:: pythonstackstack
# Recipe:: postgresql_master
#
# Copyright 2014, Rackspace
#

include_recipe 'pythonstack::postgresql_base'

include_recipe 'pg-multi::pg_master'
