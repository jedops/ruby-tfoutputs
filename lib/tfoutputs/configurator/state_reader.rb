require 'json'

module TfOutputs
  module Configurator
    class StateReader
      attr_accessor :file_paths, :outputs

      def initialize(file_paths)
        @file_paths = file_paths
        @outputs = []
        get_outputs_from_file
        self
      end

      protected

      def get_outputs_from_file
        @file_paths.each do |path, _use_sensitive|
          parser = JSON.parse(File.read(path))
          parser['modules'].each do |tf_module|
            parse_outputs(tf_module)
          end
        end
      end

      protected
      def parse_outputs(tf_module)
        if tf_module['path'] == ['root']
          tf_module['outputs'].collect do |k, v|
            @outputs.each { |output| raise "Duplicate key found #{k}" if output.key?(k) }
            @outputs.push(k => v)
          end
        end
      end

      def respond_to? (method, include_private = false)
        outputs.each do |output|
          next unless output.keys[0] == method.to_s
          return true
        end
        super
      end

      def method_missing(name, *args, &block)
        #  Hack - really we should call respond_to?
        outputs.each do |output|
          next unless output.keys[0] == name.to_s
          return 'sensitive' if output[name.to_s]['sensitive']
          return output[name.to_s]['value']
        end
        super(name, *args, &block)
      end
    end
  end
end
