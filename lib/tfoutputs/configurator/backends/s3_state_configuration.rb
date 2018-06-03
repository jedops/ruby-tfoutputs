require 'aws-sdk'
require 'tempfile'

module TfOutputs
  module Configurator
    module Backends
      class S3StateConfiguration
        :attr_accessor
        def initialize(options)
          @bucket_name = options[:bucket_name]
          @bucket_key = options[:bucket_key]
          @bucket_region = options[:bucket_region]
          @profile = options[:profile] ? options[:profile] : nil
        end

        def save
          file = Tempfile.new('tf_state')

          # Setup the base client config which must always have a bucket region
          client_config = {region: @bucket_region}
          # if a profile was supplied, then add that to the client config
          if !@profile.nil?
            client_config[:profile] = @profile
          end

          # setup s3 client
          s3 = Aws::S3::Client.new(client_config)
          resp = s3.get_object bucket: @bucket_name, key: @bucket_key
          file.write(resp.body.string)
          file.rewind
          file
        end
      end
    end
  end
end
