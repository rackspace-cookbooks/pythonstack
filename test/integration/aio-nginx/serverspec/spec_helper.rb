# Encoding: utf-8
require 'serverspec'
require 'net/http'

set :backend, :exec
set :path, '/sbin:/usr/local/sbin:/bin:/usr/bin:$PATH'

def page_returns(url = 'http://localhost/')
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Get.new(uri.request_uri)
  req.initialize_http_header({'Host' => 'example.com'})
  http.request(req).body
end
