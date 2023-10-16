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
      yaml_data = {
        "potions" => list_of_potions,
        "ingredients" => list_of_ingredients,
      }.to_yaml
      File.write(Shared::FILE_NAME, yaml_data)
    end

    private

    def list_of_ingredients
      list.map(&:name).sort.to_h { |name| [name, 0] }
    end

    def list_of_potions
      potions = config_yaml["potions"] || {}

      Shared::MAKING_EFFECTS.to_h do |name|
        [name, potions[name] || 0]
      end
    end

    def config_yaml
      @_config_yaml ||= YAML.load_file(Shared::FILE_NAME)
    end
  end
end
