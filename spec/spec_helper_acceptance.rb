require 'rspec'
require_relative '../lib/tfoutputs/configurator/s3_state_configuration'
require 'webmock/rspec'
require 'vcr'
require 'tfoutputs'
WebMock.disable_net_connect!
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end
