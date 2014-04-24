# encoding: utf-8
require 'minitest'
require 'mocha/setup'
require 'English'
require 'docker'
require 'tempfile'
require 'pp'

RSpec.configure do |c|
  c.mock_with 'mocha'
  c.color = true
  c.formatter = 'doc'

  # Fail overall as soon as first test fails.
  # Fail fast to reduce duration of test runs.
  # IOW get out of the way so that the next pull request gets tested.
  c.fail_fast = true

  # show times for 10 slowest examples (unless there are failed examples)
  c.profile_examples = true

  # Make it easy for spec tests to find fixtures.
  c.add_setting :fixture_path, default: nil
  c.fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))
end
