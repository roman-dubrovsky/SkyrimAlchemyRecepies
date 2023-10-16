# frozen_string_literal: true

require "yaml"

module Actions
  class IngredientsList
    class ParseDlcIngredients
      FILE_NAME = "lib/actions/ingredients_list/dlc_ingredients.yml"

      def self.call
        new.call
      end

      def call
        YAML.load_file(FILE_NAME) || {}
      end
    end
  end
end
