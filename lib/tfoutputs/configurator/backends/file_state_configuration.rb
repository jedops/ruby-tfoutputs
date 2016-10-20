module TfOutputs
  module Configurator
    class FileStateConfiguration
      def initialize(options)
        @options = options
      end

      def save
        File.new (@options[:file_path])
      end
    end
  end
end
