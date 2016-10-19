require 'tfoutput/configurator/version'
require 'tfoutput/configurator/state_configurator'
require 'tfoutput/configurator/state_reader'

# Expect a list of files and options:

module TfOutput
  def configure(options)
    if options.is_a?(Hash)
      file_list = TfOutput::Configurator::StateConfigurator.new([options]).file_list
    end
    file_list ||= TfOutput::Configurator::StateConfigurator.new(options).file_list
    TfOutput::Configurator::StateReader.new(file_list)
  end
  module_function :configure
end
