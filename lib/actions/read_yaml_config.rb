# frozen_string_literal: true

require "yaml"
require_relative "../shared"

module Actions
  class ReadYamlConfig
    attr_reader :list

    def initialize(list)
      @list = list
    end

    def call
      list.each do |ingredient|
        ingredient.count = ingredients_count[ingredient.name] || 0
      end

      potions
    end

    private

    def potions
      config_yaml["potions"]
    end

    def ingredients_count
      @_ingredients_count ||= config_yaml["ingredients"]
    end

    def config_yaml
      @_config_yaml ||= YAML.load_file(Shared::FILE_NAME)
    end
  end
end
