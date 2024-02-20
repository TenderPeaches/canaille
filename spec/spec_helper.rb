# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

require 'support/spec_test_helper'

RSpec.configure do |config|

  # rspec-expectations config goes here
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # include custom helpers
  config.include SpecTestHelper, type: :system
  config.disable_monkey_patching!

  #! Activate for comprehensive tests
  #config.order = :random

  config.failure_color = :bold_red

  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  #config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  #config.example_status_persistence_file_path = "spec/examples.txt"


  # This setting enables warnings. It's recommended, but in some cases may
  # be too noisy due to issues in dependencies.
  #config.warnings = true

  #config.profile_examples = 10
end
