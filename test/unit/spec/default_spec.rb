# Encoding: utf-8

require_relative 'spec_helper'

describe 'pythonstack::default' do
  before { stub_resources }
  describe 'if Monitoring is enabled' do
    context 'and Newrelic is enabled' do
      let(:chef_run) { ChefSpec::Runner.new(::UBUNTU_OPTS) do |node|
        node.set['pythonstack']['monitoring']['enabled'] = true
        node.set['pythonstack']['monitoring']['newrelic'] = true
      end.converge(described_recipe) }
      it 'includes the Newrelic recipe' do
        expect(chef_run).to include_recipe('pythonstack::newrelic')
      end
    end
    describe 'and cloud monitoring is enabled' do
      context 'when we install nginx' do
        let(:chef_run) { ChefSpec::Runner.new(::UBUNTU_OPTS) do |node|
          node.set['pythonstack']['demo']['enabled'] = true
          node.set['pythonstack']['monitoring']['enabled'] = true
          node.set['pythonstack']['monitoring']['cloudmonitoring'] = true
          node.set['platformstack']['cloud_monitoring']['enabled'] = true
        end.converge('pythonstack::nginx') }
        it 'deploys cloud-monitoring configuration for HTTP' do
          expect(chef_run).to render_file('/etc/rackspace-monitoring-agent.conf.d/example.com-http-monitor.yaml')
        end
      end
      context 'when we install ...' do
        it 'cloud monitors something' do
          skip('todo')
        end
      end
    end
    describe 'and cloud monitoring is disabled' do
      context 'when we install nginx' do
        let(:chef_run) { ChefSpec::Runner.new(::UBUNTU_OPTS) do |node|
          node.set['pythonstack']['demo']['enabled'] = true
          node.set['pythonstack']['monitoring']['enabled'] = true
          node.set['pythonstack']['monitoring']['cloudmonitoring'] = false
          node.set['platformstack']['cloud_monitoring']['enabled'] = true
        end.converge('pythonstack::nginx') }
        it 'doesn\'t deploy cloud-monitoring configuration for HTTP' do
          expect(chef_run).to_not render_file('/etc/rackspace-monitoring-agent.conf.d/example.com-http-monitor.yaml')
        end
      end
    end
    context 'when we install ...' do
      it 'cloud monitors something' do
        skip('todo')
      end
    end
 end
end
