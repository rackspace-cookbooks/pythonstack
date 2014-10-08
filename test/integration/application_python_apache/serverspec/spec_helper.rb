# Encoding: utf-8
require 'serverspec'
require 'net/http'

set :backend, :exec
set :path, '/sbin:/usr/local/sbin:/bin:/usr/bin:$PATH'

def page_returns(url = 'http://localhost/')
  Net::HTTP.get(URI(url))
end
