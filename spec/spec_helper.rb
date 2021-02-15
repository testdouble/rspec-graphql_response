require "bundler/setup"
require "rspec/graphql_response"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each, type: :graphql) do
    binding.pry
    RSpec::GraphqlResponse.reset_configuration
  end
end
