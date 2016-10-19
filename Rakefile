require 'bundler/gem_tasks'
require 'rake'
require 'rspec/core/rake_task'
require 'tfoutputs/tooling/vcr_redacter'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
end

task :rubocop do
  sh('rubocop')
end

def redact(dir)
  # Remove some but NOT necessarily all sensitive data from the VCR cassettes
  vcr_redacter = VCRRedacter.new
  puts("redacting: #{dir}")
  vcr_redacter.redact(dir)
end

at_exit do
  unless redact(Dir.pwd + '/spec/fixtures/vcr_cassettes') == 0
    raise('WARNING: VCR CASSETTES MAY NOT HAVE BEEN REDACTED INVESTIGATE BEFORE PUSHING CHANGES')
  end
end
