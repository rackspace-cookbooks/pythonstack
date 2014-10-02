# Encoding: utf-8

require_relative 'spec_helper'

describe port(80) do
  it { should be_listening }
end

# python
describe file('/etc/pythonstack.ini') do
  it { should be_file }
end
