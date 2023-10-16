# frozen_string_literal: true

module Actions
  class PrepareBestListForCrafting
    def initialize(potions)
      @potions = potions
    end

    def call
      result = []
      potions = @potions

      while potions.any?
        best_variant = potions.shift
        best_variant.pin_potion
        result << best_variant

        potions.recalculate!
      end

      result
    end
  end
end
