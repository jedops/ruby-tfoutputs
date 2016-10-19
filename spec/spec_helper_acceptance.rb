require 'rspec'
require_relative '../lib/tfoutput/configurator/s3_state_configuration'
require 'webmock/rspec'
require 'vcr'
require 'tfoutput'
WebMock.disable_net_connect!
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end
