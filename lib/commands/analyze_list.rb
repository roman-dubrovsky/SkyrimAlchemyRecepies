# frozen_string_literal: true

require_relative "../actions/parse_ingredients"
require_relative "../actions/set_ingredients_count"
require_relative "../actions/prepare_best_list_for_crafting"

module Commands
  class AnalyzeList
    attr_reader :list

    def initialize
      @list = Actions::ParseIngredients.call
      Actions::SetIngredientsCount.new(list).call
    end

    def call
      potions.each do |potion|
        puts potion.print
      end
    end

    private

    def potions
      @_potions ||= Actions::PrepareBestListForCrafting.new(list).call
    end
  end
end
