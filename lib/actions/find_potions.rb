# frozen_string_literal: true

require_relative "../shared"
require_relative "../entities/potion"
require_relative "../potions_repository"

module Actions
  class FindPotions
    attr_reader :list, :result

    def initialize(list:)
      @list = list
      @result = []
    end

    def call
      filterred_items.each.with_index do |ingredient1, index1|
        ((index1 + 1)..(count - 1)).to_a.each do |index2|
          ingredient2 = filterred_items[index2]

          matches = match_items(ingredient1, ingredient2)

          next if matches.empty?

          result << Potion.new(matches, ingredient1, ingredient2)
          try_to_find_third_ingredient(ingredient1: ingredient1, ingredient2: ingredient2, index: index2)
        end
      end

      PotionsRepository.new(result)
    end

    private

    def try_to_find_third_ingredient(ingredient1:, ingredient2:, index:)
      ((index + 1)..(count - 1)).to_a.each do |index3|
        ingredient3 = filterred_items[index3]

        matches = match_items(ingredient1, ingredient3) + match_items(ingredient2, ingredient3)
        next if matches.empty?

        current_matches = matches + match_items(ingredient1, ingredient2)
        result << Potion.new(current_matches.uniq, ingredient1, ingredient2, ingredient3)
      end
    end

    def match_items(item1, item2)
      item1.effects & item2.effects
    end

    def count
      filterred_items.count
    end

    def filterred_items
      @_filterred_items ||= list.reject do |ingredient|
        ingredient.count.zero?
      end
    end
  end
end
