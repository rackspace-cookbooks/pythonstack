source "https://supermarket.chef.io"

metadata

cookbook 'cron', git: 'git@github.com:rackspace-cookbooks/cron.git'
cookbook 'logstash', git:'git@github.com:racker/chef-logstash.git'
# until https://github.com/elastic/cookbook-elasticsearch/pull/230
cookbook 'elasticsearch', '~> 0.3', git:'git@github.com:racker/cookbook-elasticsearch.git'

group :integration do
  cookbook 'disable_ipv6', path: 'test/fixtures/cookbooks/disable_ipv6'
  cookbook 'wrapper', path: 'test/fixtures/cookbooks/wrapper'
  cookbook 'apt'
  cookbook 'yum'
end
