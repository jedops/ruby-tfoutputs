require 'spec_helper'

describe 'state reader' do
  before(:each) do
    cwd = File.expand_path(File.dirname(__FILE__))
    @tf_state = "#{cwd}/resources/terraform.tfstate"
    @sc = TfOutputs::Configurator::StateConfigurator.new([{backend: 'file', options: {file_path: @tf_state } },
                                                          { backend: 's3', options: { bucket_name: 'bucket-for-tf-configuration-tests',
                                                                                         bucket_region: 'eu-west-1', bucket_key: 'this-is-a-test.json' } }])
  end
  it 'should return file list with options' do
    VCR.use_cassette('get_file_list_from_options') do
      @sc.file_list.each do |file|
        expect(file).to be_an_instance_of(File).or be_an_instance_of(Tempfile)
      end
    end
  end
end
