module TfOutput
  module Configurator
    class FileStateConfiguration
      attr_accessor :file_paths

      def initialize(options)
        @options = options
      end

      def save
        File.new (@options[:file_path])
      end
    end
  end
end
