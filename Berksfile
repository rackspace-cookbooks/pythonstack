source "https://api.berkshelf.com"

cookbook 'rackspace_cloudbackup', git: 'git@github.com:rackspace-cookbooks/rackspace_cloudbackup.git'
cookbook 'rackspace_gluster', git: 'git@github.com:rackspace-cookbooks/rackspace_gluster.git'
cookbook 'cron', git: 'git@github.com:rackspace-cookbooks/cron.git'
cookbook 'pg-multi', git: 'git@github.com:rackspace-cookbooks/pg-multi.git'
cookbook 'monit', git: 'git@github.com:apsoto/monit.git'
cookbook 'redis-multi', git: 'git@github.com:rackspace-cookbooks/redis-multi'

group :integration do
  cookbook 'apt'
  cookbook 'yum'
end

metadata
