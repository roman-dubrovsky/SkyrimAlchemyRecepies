require_relative "find_potions"

module Actions
  class PrepareBestListForCrafting
    attr_reader :list

    def initialize(list)
      @list = list
    end

    def call
      result = []
      potions = Actions::FindPotions.new(list: list).call.sort_by(&:effects_price).reverse

      while potions.any?
        best_variant = potions.shift
        best_variant.pin_potion
        result << best_variant

        potions = potions.select { |potion| potion.count > 0 }
      end

      result
    end
  end
end
