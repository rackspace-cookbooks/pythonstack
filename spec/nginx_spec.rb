require 'spec_helper'

describe 'pythonstack::nginx' do

  context 'Ubuntu' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set['pythonstack']['demo']['enabled'] = true
        node.set['platformstack']['cloud_backup']['enabled'] = false
        node.set['platformstack']['cloud_monitoring']['enabled'] = false
        node.set['authorization']['sudo']['users'] = ['vagrant']
        node.set['authorization']['sudo']['passwordless'] = true
      end.converge(described_recipe)
    end
    before do
        stub_command('which nginx').and_return('/usr/bin/nginx')
    end
    it 'creates a nginx site configuration' do
      expect(chef_run).to render_file('/etc/nginx/sites-available/example.com').with_content('server')
    end
  end

  context 'Centos' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'centos', version: '6.5') do |node|
        node.set['pythonstack']['demo']['enabled'] = true
        node.set['platformstack']['cloud_backup']['enabled'] = false
        node.set['platformstack']['cloud_monitoring']['enabled'] = false
        node.set['authorization']['sudo']['users'] = ['vagrant']
        node.set['authorization']['sudo']['passwordless'] = true
      end.converge(described_recipe)
    end
    before do
      stub_command('which nginx').and_return('/usr/bin/nginx')
      stub_command("rpm -qa | grep -q '^runit'").and_return(true)
    end
    it 'creates a nginx site configuration' do
      expect(chef_run).to render_file('/etc/nginx/sites-available/example.com').with_content('server')
    end
  end
end
