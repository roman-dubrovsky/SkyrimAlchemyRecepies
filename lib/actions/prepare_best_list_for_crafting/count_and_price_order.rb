# frozen_string_literal: true

require_relative "base_order"

module Actions
  class PrepareBestListForCrafting
    class CountAndPriceOrder < BaseOrder
      private

      def set_ordering
        potions.reorder_potions(:effects_price_with_count)
      end

      def break_value(potion)
        potion.effects_price_with_count
      end
    end
  end
end
