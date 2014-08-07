


include_recipe 'redis-multi'
include_recipe 'redis-multi::single'
include_recipe 'redis-multi::enable'

# allow traffic to postgresql port for local addresses only
add_iptables_rule('INPUT', "-m tcp -p tcp --dport #{node['redis-multi']['bind_port']} -j ACCEPT", 9999, 'Open port for redis')