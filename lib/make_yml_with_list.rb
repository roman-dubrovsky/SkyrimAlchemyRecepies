require 'yaml'

require_relative "shared"

class MarkYmlWithList
  attr_reader :list

  def self.call(list)
    new(list).call
  end

  def initialize(list)
    @list = list
  end

  def call
    sorted_hash = list.map { |item| item.name }.sort.map { |name| [name, 0] }.to_h
    yaml_data = sorted_hash.to_yaml
    File.open(Shared::FILE_NAME, 'w') { |file| file.write(yaml_data) }
  end
end
