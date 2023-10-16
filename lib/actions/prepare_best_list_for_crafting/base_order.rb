# frozen_string_literal: true

module Actions
  class PrepareBestListForCrafting
    class BaseOrder
      attr_reader :potions

      def initialize(potions)
        @potions = potions
      end

      def call(min = 0)
        result = []

        set_ordering

        while potions.any?
          best_variant = potions.shift
          break if break_value(best_variant) < min

          best_variant.pin_potion
          result << best_variant

          potions.recalculate!
        end

        result
      end
    end
  end
end
