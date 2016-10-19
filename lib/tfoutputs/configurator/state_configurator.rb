require 'active_support/inflector'

module TfOutputs
  module Configurator
    class StateConfigurator
      attr_accessor :state_uris

      BACKENDS = { s3: 's3_state_configuration',
                   file: 'file_state_configuration' }.freeze

      BACKENDS.each { |_backend, filename| require "tfoutputs/configurator/#{filename}" }

      def initialize(states_array)
        @states_array = states_array
      end

      def file_list
        file_list = []
        @states_array.each do |state_hash|
          backend_name = state_hash[:backend]
          class_name = BACKENDS[backend_name.to_sym]
          clazz = Object.const_get("TfOutputs::Configurator::#{class_name.camelize}")
          state = clazz.new (state_hash[:options])
          file_list.push(state.save)
        end
        file_list
      end
    end
  end
end
