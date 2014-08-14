# Encoding: utf-8

require_relative 'spec_helper'

# apache
if os[:family] == 'RedHat'
  describe service('httpd') do
    it { should be_enabled }
  end
  apache2ctl = '/usr/sbin/apachectl'
else
  describe service('apache2') do
    it { should be_enabled }
  end
  apache2ctl = '/usr/sbin/apachectl'
end
describe port(80) do
  it { should be_listening }
end
describe command("#{apache2ctl} -M") do
  it { should return_stdout(/^ ssl_module/) }
end

# memcache
describe service('memcached') do
  it { should be_enabled }
  it { should be_running }
end
describe port(11_211) do
  it { should be_listening }
end

# mysql-master
if os[:family] == 'RedHat'
  describe service('mysqld') do
    it { should be_enabled }
    it { should be_running }
  end
else
  describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
  end
end
describe port(3306) do
  it { should be_listening }
end

# varnish
describe service('varnish') do
  it { should be_enabled }
  it { should be_running }
end
describe port(6081) do
  it { should be_listening }
end

# rabbitmq
describe service('rabbitmq-server') do
  it { should be_enabled }
  it { should be_running }
end
describe port(6872) do
  it { should be_listening }
end

# pythonstack.ini
describe file('/etc/pythonstack.ini') do
  it { should be_file }
end
