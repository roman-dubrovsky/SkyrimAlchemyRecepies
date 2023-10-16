# frozen_string_literal: true

require_relative "../config"
require_relative "../actions/ingredients_list"
require_relative "../actions/read_yaml_config"
require_relative "../actions/find_potions"
require_relative "../actions/reserve_ingredients"
require_relative "../actions/prepare_best_list_for_crafting"

module Commands
  class AnalyzeList
    attr_reader :list, :reserve_potions_count, :config

    def initialize
      @list = Actions::IngredientsList.call
      @config = Config.new
      @reserve_potions_count = config.potions
    end

    def call
      Actions::ReadYamlConfig.new(list, config).call

      potions_for_reserving.each(&:print)
      puts "==============================="
      potions_for_selling.each do |potion|
        puts potion.print
      end
    end

    private

    def potions_for_reserving
      @_potions_for_reserving ||= Actions::ReserveIngredients.new(potions: potions, reserve: reserve_potions_count).call
    end

    def potions_for_selling
      @_potions_for_selling ||= Actions::PrepareBestListForCrafting.new(potions).call
    end

    def potions
      @_potions ||= Actions::FindPotions.new(list: list).call
    end
  end
end
