# frozen_string_literal: true

require "yaml"

require_relative "../config"

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
      config_yaml.write(
        potions: list_of_potions,
        ingredients: list_of_ingredients,
      )
    end

    private

    def list_of_ingredients
      list.map(&:name).sort.to_h { |name| [name, 0] }
    end

    def list_of_potions
      potions = config_yaml.potions

      Shared::MAKING_EFFECTS.to_h do |name|
        [name, potions[name] || 0]
      end
    end

    def config_yaml
      @_config_yaml ||= Config.new
    end
  end
end
