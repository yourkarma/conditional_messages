RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.expect_with :rspec do |rspec|
    rspec.syntax = :expect
  end
end
