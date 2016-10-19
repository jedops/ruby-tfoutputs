require 'spec_helper_acceptance'

describe 'state reader' do
  before(:each) do
    @config = { backend: 's3', options: { bucket_name: 'bucket-for-tf-configuration-tests',
                                          bucket_region: 'eu-west-1', bucket_key: 'terraform.tfstate' } }
  end
  it 'should just bloody work' do
    VCR.use_cassette('e2e-test-single-hash') do
      sc = TfOutputs.configure(@config)
      expect(sc.cf_size).to eq('tiny')
    end
  end

  it 'should just bloody work with multiple array values' do
    VCR.use_cassette('e2e-test-array-of-hashes') do
      cwd = File.expand_path(File.dirname(__FILE__))
      tf_state = "#{cwd}/resources/terraform_acceptance_array_of_hashes.tfstate"
      config_array = [
        { backend: 's3', options: { bucket_name: 'bucket-for-tf-configuration-tests',
                                    bucket_region: 'eu-west-1', bucket_key: 'terraform.tfstate' } },
        { backend: 'file', options: { file_path: tf_state } }
      ]
      sc = TfOutputs.configure(config_array)
      expect(sc.cf_size).to eq('tiny')
      expect(sc.services_z2_count_2).to eq('it works')
    end
  end
end
