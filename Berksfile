source "https://api.berkshelf.com"

cookbook 'logstash_stack', git: 'git@github.com:rackspace-cookbooks/logstash_stack.git'
cookbook 'rackspace_iptables', git: 'git@github.com:rackspace-cookbooks/rackspace_iptables.git'
cookbook 'rackspacecloud', git: 'git@github.com:rackspace-cookbooks/rackspacecloud.git'
cookbook 'rackspace_cloudbackup', git: 'git@github.com:rackspace-cookbooks/rackspace_cloudbackup.git'
cookbook 'rackspace_gluster', git: 'git@github.com:rackspace-cookbooks/rackspace_gluster.git'
cookbook 'rackops_rolebook', git: 'git@github.com:rackops/rackops_rolebook.git'
cookbook 'cron', git: 'git@github.com:rackspace-cookbooks/cron.git'
cookbook 'pg-multi', git: 'git@github.com:rackspace-cookbooks/pg-multi.git'
cookbook 'monit', git: 'git@github.com:apsoto/monit.git'
cookbook 'redis-multi', git: 'git@github.com:rackspace-cookbooks/redis-multi'
cookbook 'redisio', git: 'https://github.com/racker/redisio', branch: '2.0.0_wip'
cookbook 'uwsgi', git: 'https://github.com/50onRed/uwsgi'

group :integration do
  cookbook 'apt'
  cookbook 'yum'
end

metadata
