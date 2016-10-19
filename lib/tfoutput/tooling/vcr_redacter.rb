require 'yaml'

class VCRRedacter
  # Goes through every file in directory, looks for yaml files, attempt to parse and remove the AWS access keys from them.
  def redact(path)
    return 1 if !Dir.exist?(path) || Dir[path + '/*.yml'].empty?
    Dir.glob(path + '/*.yml') do |yml_file|
      file = YAML.load_file(yml_file)
      redacted = { 'Authorization' => ['redacted'] }
      file['http_interactions'].first['request']['headers'] = redacted
      File.open(yml_file, 'w') { |f| YAML.dump(file, f) }
    end
    0
  end
end
