# Encoding: utf-8

require_relative 'spec_helper'

describe 'configures and runs Nginx' do
  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end
  describe port(80) do
    it { should be_listening }
  end
end

# Uwsgi
describe 'configures and runs Uwsgi' do
  describe file('/var/run/uwsgi-example.com.pid') do
    it { should be_file }
  end
  describe file('/etc/nginx/example.com.ini') do
    it { should be_file }
  end
  describe port(8080) do
    it { should be_listening }
  end
  describe process('uwsgi') do
    it { should be_running }
  end
end

describe 'configures our application' do
  describe file('/etc/nginx/sites-available/example.com') do
    it { should be_file }
  end
  describe file('/etc/nginx/sites-enabled/example.com') do
    it { should be_linked_to '/etc/nginx/sites-available/example.com' }
  end
  describe file('/var/www/example.com') do
    it { should be_directory }
  end
  describe file('/etc/pythonstack.ini') do
    it { should be_file }
  end
  describe 'the app returns the expected content' do
    it { expect(page_returns).to match(/MySQL Service/) }
  end
end
