require 'tfoutputs/configurator/version'
require 'tfoutputs/configurator/state_configurator'
require 'tfoutputs/configurator/state_reader'

# Expect a list of files and options:

module TfOutputs
  def configure(options)
    if options.is_a?(Hash)
      file_list = TfOutputs::Configurator::StateConfigurator.new([options]).file_list
    end
    file_list ||= TfOutputs::Configurator::StateConfigurator.new(options).file_list
    TfOutputs::Configurator::StateReader.new(file_list)
  end
  module_function :configure
end
