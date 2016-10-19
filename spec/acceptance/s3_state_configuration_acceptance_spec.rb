require 'spec_helper_acceptance'

describe 'state reader' do
  before(:each) do
    @s3_state_configuration = TfOutput::Configurator::S3StateConfiguration.new(bucket_name: 'bucket-for-tf-configuration-tests',
                                                                               bucket_region: 'eu-west-1',
                                                                               bucket_key: 'this-is-a-test.json')
  end
  it 'should get bucket state file' do
    VCR.use_cassette('get_state_from_bucket') do
      @s3_state_configuration.save
    end
  end
end
