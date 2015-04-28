# Encoding: utf-8

require_relative 'spec_helper'

# nginx
describe 'configures and runs Nginx' do
  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end
  describe port(80) do
    it { should be_listening }
  end
end
describe 'configures our application' do
  describe file('/etc/nginx/sites-available/example.com-80.conf') do
    it { should be_file }
  end
  describe file('/etc/nginx/sites-enabled/example.com-80.conf') do
    it { should be_linked_to '/etc/nginx/sites-available/example.com-80.conf' }
  end
  describe file('/var/www/example.com') do
    it { should be_directory }
  end
  describe 'the app returns the expected content' do
    it { expect(page_returns).to match(/MySQL Service/) }
  end
end

# Uwsgi
describe 'configures and runs Uwsgi' do
  describe file('/var/run/uwsgi-example.com-80.pid') do
    it { should be_file }
  end
  describe file('/etc/nginx/example.com-20001-uwsgi.ini') do
    it { should be_file }
  end
  describe port(20_001) do
    it { should be_listening }
  end
  describe process('uwsgi') do
    it { should be_running }
  end
end

# memcache
describe service('memcached') do
  it { should be_enabled }
  it { should be_running }
end
describe port(11_211) do
  it { should be_listening }
end

# postgresql base
if os[:family] == 'redhat'
  # process is named postgres
  describe service('postgres') do
    it { should be_running }
  end
  # service is named postgresql...
  describe service('postgresql') do
    it { should be_enabled }
  end
else
  describe service('postgresql') do
    it { should be_enabled }
    it { should be_running }
  end
end
describe port(5432) do
  it { should be_listening }
end

# mongo
describe port(27_017) do
  it { should be_listening }
end

# redis
# cannot name the service redis6379 because the check uses ps, not the actual service name
describe service('redis') do
  it { should be_running }
end
if os[:family] == 'redhat'
  describe service('redis6379') do
    it { should be_enabled }
  end
end
describe port(6379) do
  it { should be_listening }
end

# pythonstack.ini
describe file('/etc/pythonstack.ini') do
  it { should be_file }
end
