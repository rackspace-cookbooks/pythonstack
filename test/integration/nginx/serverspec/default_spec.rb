# Encoding: utf-8

require_relative 'spec_helper'

# nginx
if os[:family] == 'RedHat'
  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end
else
  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end
end
describe port(80) do
  it { should be_listening }
end

# Uwsgi
describe file('/var/run/uwsgi-example.com.pid') do
  it { should be_file }
end
describe process('uwsgi') do
  it { should be_running }
end

# FIXME: Uwsgi cookbooks is using sv which is not supported by serverspec
# describe service('uwsgi-example.com') do
#   it { should be_enabled }
#   it { should be_running }
# end
# describe port(8080) do
#   it { should be_listening }
# end
