require_relative "../shared"
require_relative "../entities/potion"

module Actions
  class FindPotions
    attr_reader :list

    def initialize(list:)
      @list = list
    end

    def call
      result = []
      count = filterred_items.count

      filterred_items.each.with_index do |ingredient1, index1|
        ((index1 + 1)..(count - 1)).to_a.each do |index2|
          ingredient2 = filterred_items[index2]

          matches = match_items(ingredient1, ingredient2)

          next if matches.empty?

          result << Potion.new(matches, ingredient1, ingredient2)

          ((index2 + 1)..(count - 1)).to_a.each do |index3|
            ingredient3 = filterred_items[index3]

            matches1_3 = match_items(ingredient1, ingredient3)
            matches2_3 = match_items(ingredient2, ingredient3)
            next if matches1_3.empty? && matches2_3.empty?

            current_matches = matches + matches1_3 + matches2_3
            result << Potion.new(current_matches.uniq, ingredient1, ingredient2, ingredient3)
          end
        end
      end

      result
    end

    private

    def match_items(item1, item2)
      item1.effects & item2.effects
    end

    def filterred_items
      @_filterred_items ||= list.reject do |ingredient|
        ingredient.count.zero?
      end
    end
  end
end
