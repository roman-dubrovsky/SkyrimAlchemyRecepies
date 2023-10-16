# frozen_string_literal: true

require_relative "prepare_best_list_for_crafting/standart_order"
require_relative "prepare_best_list_for_crafting/count_and_price_order"

module Actions
  class PrepareBestListForCrafting
    attr_reader :potions, :config

    FIRST_POINT = 300
    SECOND_POINT = 150

    def initialize(potions, config)
      @potions = potions
      @config = config
    end

    def call
      if config.optimize_crafting?
        [
          StandartOrder.new(potions).call(FIRST_POINT),
          CountAndPriceOrder.new(potions).call(SECOND_POINT),
        ]
      else
        [
          StandartOrder.new(potions).call,
        ]
      end
    end
  end
end
