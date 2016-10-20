module TfOutputs
  module Configurator
    module Backends
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
end
