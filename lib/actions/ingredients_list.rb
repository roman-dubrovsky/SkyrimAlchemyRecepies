# frozen_string_literal: true

require_relative "../entities/ingredient"
require_relative "ingredients_list/parse_ingredients"
require_relative "ingredients_list/parse_dlc_ingredients"

module Actions
  class IngredientsList
    attr_reader :result

    def self.call
      new.call
    end

    def initialize
      @result = []
    end

    def call
      parsed_ingredients.merge(dlc_ingredients).to_a.map do |name, effects|
        Ingredient.new(name, effects)
      end
    end

    private

    def dlc_ingredients
      @_dlc_ingredients ||= Actions::IngredientsList::ParseDlcIngredients.call
    end

    def parsed_ingredients
      @_parsed_ingredients ||= Actions::IngredientsList::ParseIngredients.call
    end
  end
end
