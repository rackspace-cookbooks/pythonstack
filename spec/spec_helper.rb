require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
      config.log_level = :debug
end
at_exit { ChefSpec::Coverage.report! }
