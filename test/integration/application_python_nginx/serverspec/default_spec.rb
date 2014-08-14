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

# Uswgi
#
describe service('uwsgi-demo') do
  it { should be_enabled }
  it { should be_running }
end
describe port(8080) do
  it { should be_listening }
end
