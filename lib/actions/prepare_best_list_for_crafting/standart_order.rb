# frozen_string_literal: true

require_relative "base_order"

module Actions
  class PrepareBestListForCrafting
    class StandartOrder < BaseOrder
      private

      def set_ordering
        potions.reorder_potions(:effects_price)
      end

      def break_value(potion)
        potion.effects_price
      end
    end
  end
end
