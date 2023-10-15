# frozen_string_literal: true

require "yaml"

require_relative "../shared"

module Actions
  class MarkYmlWithList
    attr_reader :list

    def self.call(list)
      new(list).call
    end

    def initialize(list)
      @list = list
    end

    def call
      sorted_hash = list.map(&:name).sort.to_h { |name| [name, 0] }
      yaml_data = sorted_hash.to_yaml
      File.write(Shared::FILE_NAME, yaml_data)
    end
  end
end
