# frozen_string_literal: true

require 'pathname'

SPEC_ROOT = root = Pathname(__FILE__).dirname

require 'rspec'

require 'rack/test'
require 'omniauth'
require 'omniauth-huawei'

Dir[root.join('support/*.rb').to_s].sort.each do |f|
  require f
end

Dir[root.join('shared/*.rb').to_s].sort.each do |f|
  require f
end
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros
  config.include OmniAuth::Test::StrategyTestCase
end
